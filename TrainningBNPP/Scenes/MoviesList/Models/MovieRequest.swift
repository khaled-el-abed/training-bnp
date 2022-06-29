//
//  MovieRequest.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 23/06/2022.
//

import Foundation

enum MovieRequest: RequestProtocol {
    var urlString: String {
        switch self {
        case .movies(let query):
            return Router.Path.movies + "?query=\(query)"
        }
    }

    var method: HttpMethod {
        switch self {
        case .movies: return .get
        }
    }

    case movies(query: String)
}
