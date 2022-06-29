//
//  MovieViewModel.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 22/06/2022.
//

import Foundation
import RxCocoa
import RxSwift

final class MoviesViewModel: GenericTableViewModel<MovieViewModel>, MovieServiceProvider {
    
    // MARK: - Public Properties

    struct Input {
        var name: BehaviorRelay<String?>
        let selectedMovie: BehaviorRelay<MovieViewModel?>
    }

    let input: Input

    var movies: Driver<[MovieViewModel]> {
        dataSource.asDriver()
    }

    let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Initialization
    
    override init() {
        
        input = Input(name: BehaviorRelay(value: nil),
                      selectedMovie: BehaviorRelay(value: nil))
        
        super.init()
        
        setupBinding()
    }

    // MARK: - Private Functions
    
    private func setupBinding() {
        input.name.skip(1).subscribe(onNext: { name in
            self.fetchMovie(with: name ?? "")
        }).disposed(by: disposeBag)
    }
    
    private func fetchMovie(with name: String) {
        isLoading.accept(true)
         movieService.fetchMovie(by: name) { [weak self] response in
            
            self?.isLoading.accept(false)
            switch response {
            case .success(let movieResponse):
                let results = movieResponse.results?.map { MovieViewModel(movie: $0) }
                self?.dataSource.accept(results ?? [] )
            case .failure(let error):
                self?.hasError.accept(error)
            }
        }
    }
    
}


