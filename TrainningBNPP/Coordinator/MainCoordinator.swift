//
//  MainCoordinator.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 23/06/2022.
//

import UIKit

protocol Coordinator {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}

final class MainCoordinator: Coordinator {
    
    let navigationController = UINavigationController()
    var mainCoordinator: Coordinator!
    var onDismiss: (() -> Void)?
    
    // MARK: - Initialization
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Private Methods
    
    private let window: UIWindow
    
    // MARK: - Public Methods
    
    func start() {
       
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        mainCoordinator = MoviesCoordinator(navigationController: navigationController)
        coordinate(to: mainCoordinator)
    }
}
