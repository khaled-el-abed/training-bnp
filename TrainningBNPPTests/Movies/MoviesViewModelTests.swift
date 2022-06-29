//
//  MoviesViewModelTests.swift
//  TrainningBNPPTests
//
//  Created by Khaled El Abed on 23/06/2022.
//

import XCTest
import RxBlocking
import RxTest
import RxSwift
import Swinject
@testable import TrainningBNPP

final class MoviesViewModelTests: GenericViewModelTest {
    
    var viewModel: MoviesViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        
        Container.shared.register(MovieServiceProtocol.self) { _ in
            MovieService()
        }.inObjectScope(.container)
        
        viewModel = MoviesViewModel()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    func testMoviesWithError() {
        
        // Create testable observers
        let rates = scheduler.createObserver([MovieViewModel].self)
        let errorMessage = scheduler.createObserver(BnpError?.self)

        // giving a service with no currencies
        //service.converter = nil

        viewModel.hasError
            .subscribe(errorMessage)
            .disposed(by: disposeBag)

        viewModel.movies
            .drive(rates)
            .disposed(by: disposeBag)

        // when fetching the service
        scheduler.createColdObservable([.next(10, "fi")])
            .bind(to: viewModel.input.name)
            .disposed(by: disposeBag)
        scheduler.start()

        // expected error message
        XCTAssertEqual(errorMessage.events, [.next(10, .notFound)])
    }
    
   func testMoviesCount() {        
        // Create scheduler with the observer type
        let movies = scheduler.createObserver([MovieViewModel].self)

       
       
        // Get expected result
        let expectedMovies: [MovieViewModel] = MockHelper.getMovies().map { MovieViewModel(movie: $0) }

//       expectedMovies.forEach ({ print("**🔥**", type(of: self), #function, $0.movie.id) })
        
       // Bind the result to the obser
        viewModel.movies.drive(movies).disposed(by: disposeBag)
        //viewModel.movies.asObservable().subscribe(movies).disposed(by: disposeBag)
//       let isFirstEnabled = viewModel.isFirstEnabled.subscribeOn(scheduler)
       
//       viewModel.input.name.accept("fight")
        
       XCTAssertRecordedElements(movies.events, [[]])

       
       // Mock the input title
        scheduler.createColdObservable([.next(10, "fight")])
            .bind(to: viewModel.input.name)
            .disposed(by: disposeBag)

       // viewModel.input.name.accept("fight")
        scheduler.start()

      
       
        // Assert
        print("**🔥**", type(of: self), #function, "Assert")
       XCTAssertEqual(movies.events, [.next(0, []), .next(10, expectedMovies) ])
       
       viewModel.movies.asObservable().subscribe(onNext: { viewModels in
           print("**🔥**", type(of: self), #function, viewModels.count)
       }).disposed(by: disposeBag)
       
       
       
    }
     
    func _testApiMock() {
        print("**🔥**", type(of: self), #function)
        Container.shared.register(MovieServiceProtocol.self) { _ in
                MovieServiceMock()
        }.inObjectScope(.container)

        viewModel.input.name.accept("fight")
        
        if let service  = viewModel.movieService as? MovieServiceMock {
            XCTAssertEqual(service.callCount, 1)
        }
        
    }
    
    
    override func tearDown() {
//        disposeBag = nil
//        viewModel = nil
//        scheduler = nil
//
        super.tearDown()
    }
    
}
