//
//  ApiClientMock.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 28/06/2022.
//

import Foundation

final class ApiClientMock: Networking {
    
    // MARK: - Constants
    
    private enum Constants {
        static let urlSeparator = "/"
        static let extensionSeparator = "?"
    }
    
    // MARK: - Public Methods
    
    func execute<T: Decodable>(_ request: RequestProtocol,
                               completion: @escaping (Result<T, BnpError>) -> Void) {
        
        
        guard let file = getFileName(from: request),
              let result = getJson(from: file) else {
            
            completion(.failure(BnpError.notFound))
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
    
    // MARK: Private Functions
    
    private func getFileName(from request: RequestProtocol) -> String? {
        guard let  url = request.urlRequest.url,
              let fileName = url.absoluteString.components(separatedBy: Constants.urlSeparator).last,
              let file = fileName.components(separatedBy: Constants.extensionSeparator).first
        else {
            return nil
        }
        
        /*
         // Get All params
         guard  let component = request.urlRequest.url?.components,
         var queries = component.queryItems else {
         return nil
         }
         
         // TODO: - Remove unecessary params
         let urlString = queries.reduce("") { text, query in "\(text)-\(query.name)-\(query.value!)"}.replacingOccurrences(of: " ", with: "-")
         //          print("**🔥**", #function, urlString)
         //file += urlString*/
        return file
    }
    
    private  func getJson(from file: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
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
