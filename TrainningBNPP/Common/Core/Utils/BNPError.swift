//
//  BNPError.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 23/06/2022.
//

import Foundation

//protocol BnpErrorProtocol: Error {
//    var title: String { get }
//    var description: String { get }
//}

enum BnpError: Error {
    case notFound
    case undefined
    
    var title: String {
        "Erreur"
    }
    
    var description: String {
        switch self {
        case .undefined:
            return "Please try later"
        case .notFound:
            return "Not found"
        }
    }
}
