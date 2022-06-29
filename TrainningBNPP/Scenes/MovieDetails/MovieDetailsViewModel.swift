//
//  MovieDetailsViewModel.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 27/06/2022.
//

import Foundation
import RxCocoa
import RxSwift

final class MovieDetailsViewModel {
    
    var title: Driver<String?> {
        _title.asDriver()
    }
    
    private(set) var _title: BehaviorRelay<String?>
    
    var description: Driver<String?> {
        _description.asDriver()
    }
    
    private(set) var _description: BehaviorRelay<String?>
    
    var date: Driver<String?> {
        _date.asDriver()
    }
    
    private(set) var _date: BehaviorRelay<String?>
    
    var poster: Driver<URL?> {
        _poster.asDriver()
    }
    
    private(set) var _poster: BehaviorRelay<URL?> = BehaviorRelay(value: nil)
    
    var banner: Driver<URL?> {
        _banner.asDriver()
    }
    
    private(set) var _banner: BehaviorRelay<URL?> = BehaviorRelay(value: nil)
    
    private(set) var movie: Movie
    
    // MARK: - Init
    
    init(movie: Movie) {
        self.movie = movie
        
        _title = BehaviorRelay(value: movie.title)
        _description = BehaviorRelay(value: movie.overview)
        _date = BehaviorRelay(value: movie.releaseDate)
        
        if let photoUrl = movie.posterUrl,
                let url = URL(string: GlobalConstants.prefixImageURL + photoUrl)  {
            print("**🔥**", type(of: self), #function, "posterUrl", url.absoluteString)
            _poster = BehaviorRelay(value: url)
        }

        if let bannerUrl = movie.backDropPath,
                let url = URL(string: GlobalConstants.prefixImageURL + bannerUrl) {
            print("**🔥**", type(of: self), #function, "banner", url.absoluteString)
            _banner = BehaviorRelay(value: url)
        }
    }

    
}
