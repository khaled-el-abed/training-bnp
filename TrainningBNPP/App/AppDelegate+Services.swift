//
//  AppDelegate+Services.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 22/06/2022.
//

import Foundation
import Swinject

extension AppDelegate {
    
    func setup() {

        Container.shared.register(ApiConfiguration.self) { _ in
            ApiConfiguration(language: Locale.current.identifier)
        }
        
        Container.shared.register(Networking.self) { _ in
            ApiClient()
        }
        
        Container.shared.register(MovieServiceProtocol.self) { resolver in
            MovieService()
        }
        
//        let mockRepo = MockMoviesRepository()
//        let remoteRepo = MockMoviesRepository()
//        let manager = MoviesManager(repository: mockRepo)
//        print(manager.whichRepository)

//        Container.shared.register(MoviesManager.self) { _ in
//            MoviesManager(repository: MockMoviesRepository())
//        }
        
        //Container.shared.resolve(Service.Type)
        
      
        
     
    }
}

// This will assembly all elements nedded to fetch movies list
final class MovieAssembler: Assembly {
    
    func assemble(container: Swinject.Container) {
        container.register(MovieService.self) { _ in
                MovieService()
        }

//        container.register(<#T##serviceType: Service.Type##Service.Type#>) { _ in
//            <#code#>
//        }
    }
}
