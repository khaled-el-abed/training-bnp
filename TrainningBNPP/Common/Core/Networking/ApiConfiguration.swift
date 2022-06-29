//
//  ApiConfiguration.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 28/06/2022.
//

import Foundation

struct ApiConfiguration {
    
    enum Constants {
        static let authrizationKey = "d2ba8efad713816aeac0d732d7cbaca8"
    }
    
    let language: String
    let authrizationKey = Constants.authrizationKey
}
