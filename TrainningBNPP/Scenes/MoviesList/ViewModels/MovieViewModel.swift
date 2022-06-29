//
//  MovieViewModel.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 22/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

final class MovieViewModel: Equatable {

    // MARK: - Constants
    
    private enum Constants {
        static let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    }
    
    // MARK: - Public Properties
    
    private(set) var _title: BehaviorRelay<String?>
    private(set) var _description: BehaviorRelay<String?>
    private(set) var _poster: BehaviorRelay<URL?> = BehaviorRelay(value: nil)
    
    var title: Driver<String?> {
        _title.asDriver()
    }
    
    var description: Driver<String?> {
        _description.asDriver()
    }

    var poster: Driver<URL?> {
        _poster.asDriver()
    }
    
    private(set) var movie: Movie
    
    // MARK: - Initialization
    
    init(movie: Movie) {
        self.movie = movie
        
        _title = BehaviorRelay(value: movie.title)
        _description = BehaviorRelay(value: movie.overview)
        
        guard let photoUrl = movie.posterUrl,
                let url = URL(string: GlobalConstants.prefixImageURL + photoUrl) else { return }
        
        _poster = BehaviorRelay(value: url)
    }
    
    static func == (lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
        return lhs.movie.id == rhs.movie.id
    }
}
