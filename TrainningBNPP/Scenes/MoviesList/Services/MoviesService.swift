//
//  MoviesService.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 22/06/2022.
//

import Foundation
import Swinject

// MARK: - Provider

protocol MovieServiceProvider {
    var movieService: MovieServiceProtocol { get }
}

extension MovieServiceProvider {
    var movieService: MovieServiceProtocol {
        return Container.shared.resolve(MovieServiceProtocol.self)!
    }
}

// MARK: - Service

protocol MovieServiceProtocol {
    
    func fetchMovie(by name: String, completion: @escaping(Result<MovieResponse, BnpError> ) -> Void)
}

final class MovieService: MovieServiceProtocol, ApiClientProvider {
    
    // MARK: - Public Functions
    
    func fetchMovie(by name: String, completion: @escaping(Result<MovieResponse, BnpError>) -> Void) {
        apiClient.execute(MovieRequest.movies(query: name), completion: completion)
    }
}
