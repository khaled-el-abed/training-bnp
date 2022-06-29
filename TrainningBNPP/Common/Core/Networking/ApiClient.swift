//
//  ApiClient.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 23/06/2022.
//

import Foundation
import Swinject

// MARK: - Provider

protocol ApiClientProvider {
    
    var apiClient: Networking { get }
}

extension ApiClientProvider {
    
    var apiClient: Networking { Container.shared.resolve(Networking.self)! }
}

// MARK: - APIClient

final class ApiClient: Networking {
    
    func execute<T: Decodable>(_ request: RequestProtocol,
                               completion: @escaping (Result<T, BnpError>) -> Void) {
        let urlRequest = request.urlRequest
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            
            DispatchQueue.main.async {
                do {
                    if let _ = error {
                        completion(.failure(.notFound))
                        return
                    }
                    
                    guard let data = data else {
                        preconditionFailure("No error was received but we also don't have data...")
                    }
                    
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(.notFound))
                }
            }
        }.resume()
    }
}


