//
//  MoviesCoordinator.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 23/06/2022.
//

import UIKit

protocol MoviesFlow: AnyObject {
    func navigateToMovieDetails(movie: Movie)
}

final class MoviesCoordinator: Coordinator {
    
    // MARK: - Private Properties
   
    private let navigationController: UINavigationController
    
    // MARK: - Initialization
    
    var childViewControlelr: [UIViewController] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Public Methods
    
    func start() {
        
        let viewController = MoviesListViewController()
        viewController.delegate = self
        viewController.viewModel = MoviesViewModel()
        
        childViewControlelr.append(viewController)
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - MoviesFlow

extension MoviesCoordinator: MoviesFlow {

    func navigateToMovieDetails(movie: Movie) {
        let detailsCoordinator = MovieDetailsCoordinator(navigationController: navigationController, movie: movie)
        coordinate(to: detailsCoordinator)
    }
}
