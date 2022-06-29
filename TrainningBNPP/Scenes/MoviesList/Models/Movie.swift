//
//  Movie.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 22/06/2022.
//

import Foundation

struct Movie: Codable {
    
    // MARK: - Public Properties
    
    let id: Int?
    let title: String?
    let releaseDate: String?
    let posterUrl: String?
    let overview: String?
    let backDropPath: String?
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title  = "title"
        case releaseDate = "release_date"
        case posterUrl = "poster_path"
        case overview = "overview"
        case backDropPath = "backdrop_path"
    }
    
//    {
//          "adult": false,
//          "backdrop_path": "/ahK0FqZ4rQItacXuS1faxRo1WHW.jpg",
//          "genre_ids": [
//            35
//          ],
//          "id": 488971,
//          "original_language": "en",
//          "original_title": "You Can't Fight Christmas",
//          "overview": "Christmas designer Leslie Major (Brely Evans) is the biggest fan of Christmas ever. She is like a tidal wave of Yuletide cheer. Her biggest job every year is decorating the lobby of the famed Chesterton Hotel. As she is on a ladder decorating the tree, she falls into the arms of Edmund James (Andra Fuller) - the grandson of the owner JJ James. Edmund is all business and thinks Christmas is superficial and frivolous.",
//          "popularity": 4.873,
//          "poster_path": "/qeceU9AsdHu9H6ZZax4MfeDj7A7.jpg",
//          "release_date": "2017-11-01",
//          "title": "You Can't Fight Christmas",
//          "video": false,
//          "vote_average": 5.5,
//          "vote_count": 34
//        }
}
