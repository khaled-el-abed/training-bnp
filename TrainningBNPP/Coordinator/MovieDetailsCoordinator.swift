//
//  MovieDetailsCoordinator.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 29/06/2022.
//

import UIKit

final class MovieDetailsCoordinator: Coordinator {
    
    // MARK: - Private Properties
   
    private let navigationController: UINavigationController
    private var movie: Movie
    
    // MARK: - Initialization
    
    var childViewControlelr: [UIViewController] = []
    
    init(navigationController: UINavigationController, movie: Movie) {
        self.navigationController = navigationController
        self.movie = movie
    }

    // MARK: - Public Methods
    
    func start() {
        
        let viewController = MovieDetailsViewController()
        viewController.viewModel = MovieDetailsViewModel(movie: movie)
        
        //childViewControlelr.append(viewController)
        navigationController.pushViewController(viewController, animated: true)
    }
}
