//
//  MovieResponse.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 23/06/2022.
//

import Foundation

struct MovieResponse: Codable {
    
    let page: Int?
    let results: [Movie]?
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
