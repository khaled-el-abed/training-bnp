//
//  NetworkingMock.swift
//  TrainningBNPPTests
//
//  Created by Khaled El Abed on 23/06/2022.
//

import XCTest
import RxCocoa
import RxSwift
import RxTest
import RxBlocking

@testable import TrainningBNPP

private enum Constants {
    static let urlSeparator = "/"
    static let extensionSeparator = "?"
}

final class NetworkingMock: Networking {
    
    func execute<T>(_ request: RequestProtocol, completion: @escaping (Result<T, BnpError>) -> Void) where T : Decodable {

        guard let file = getFileName(from: request),
              let result = getJson(from: file) else {
            DispatchQueue.main.async {
                completion(.failure(BnpError.notFound))
            }
            
            return
        }
        
        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: result)
            completion(.success(decodedObject))
        } catch {
            guard let error = error as? BnpError else { return }
            completion(.failure(error))
        }
    }
    
    private func getFileName(from request: RequestProtocol) -> String? {
        guard let  url = request.urlRequest.url,
              let fileName = url.absoluteString.components(separatedBy: Constants.urlSeparator).last,
              var file = fileName.components(separatedBy: Constants.extensionSeparator).first
        else {
            
            return nil
        }
        
        guard  let component = request.urlRequest.url?.components,
               var queries = component.queryItems else {
            return nil
        }
        
        queries.removeLast()
        queries.removeLast()
        let urlString = queries.reduce("") { text, query in "\(text)-\(query.name)-\(query.value!)"}.replacingOccurrences(of: " ", with: "-")
        file += urlString
        return file
    }
    
    private  func getJson(from file: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
//        print("**🔥**", #function, file)
        guard let path = bundle.path(forResource: file, ofType: ".json") else {
            return nil
        }
        
        do {
            let fileURL = URL(fileURLWithPath: path)
            return try Data(contentsOf: fileURL)
        } catch {
            
        }
        
        return nil
    }
}

extension URL {
    var components: URLComponents? {
        return URLComponents(url: self, resolvingAgainstBaseURL: false)
    }
}

extension Array where Iterator.Element == URLQueryItem {
    subscript(_ key: String) -> String? {
        return first(where: { $0.name == key })?.value
    }
}
