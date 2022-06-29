//
//  MockHelper.swift
//  TrainningBNPPTests
//
//  Created by Khaled El Abed on 27/06/2022.
//

import Foundation

@testable import TrainningBNPP

final class MockHelper {
    
    static func getMovies() -> [Movie] {
        return [Movie(id: 550,
                      title: "Fight Club",
                      releaseDate: "1999-10-15",
                      posterUrl: "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg",
                      overview: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
                      backDropPath: "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg"),
                Movie(id: 551,
                      title: "Fight Club",
                      releaseDate: "1999-10-15",
                      posterUrl: "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg",
                      overview: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
                      backDropPath: "/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg")
        
        ]
    }
    
    static func getMovieResponse() -> MovieResponse {
        return MovieResponse(page: 0, results: MockHelper.getMovies(), totalPages: 1, totalResults: 1)
    }
}
