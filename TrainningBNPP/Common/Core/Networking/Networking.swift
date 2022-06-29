//
//  ApiClient.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 22/06/2022.
//

import Foundation
import RxSwift

protocol Networking {
    
    /// Excure a request
    ///
    /// - Parameters:
    ///     - requestProvider: The request to provide to server
    ///     - completion: The result to get from server
    func execute<T: Decodable>(_ request: RequestProtocol, completion: @escaping (Result<T, BnpError>) -> Void)
    
}
