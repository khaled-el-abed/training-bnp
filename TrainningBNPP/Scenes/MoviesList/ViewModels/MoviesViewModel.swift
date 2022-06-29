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
    
    let disposeBag: DisposeBag = DisposeBag()
    
    struct Input {
        var name: BehaviorRelay<String?>
        let selectedMovie: BehaviorRelay<MovieViewModel?>
    }
    
    struct Output {
        
    }
    
    let input: Input

    var movies: Driver<[MovieViewModel]> {
        dataSource.asDriver()
    }
    
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

        print("**🔥**", type(of: self), #function, type(of: movieService))
        isLoading.accept(true)
         movieService.fetchMovie(by: name) { [weak self] response in
            
            self?.isLoading.accept(false)
            switch response {
            case .success(let movieResponse):
                let results = movieResponse.results?.map { MovieViewModel(movie: $0) }
                //print("**🔥**", type(of: self), #function,"result count", results?.count)
                
                self?.dataSource.accept(results ?? [] )
            case .failure(let error):
                self?.hasError.accept(error)
            }
            
        }
    }
    
}


