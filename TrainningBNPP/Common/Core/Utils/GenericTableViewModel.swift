//
//  GenericTableViewModel.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 23/06/2022.
//

import Foundation
import RxCocoa
import Swinject

protocol Mockable {
    var shouldMock: Bool { get }
    
    func activateMock(_ isActivate: Bool)
}

extension Mockable where Self: DataSourced {
    
    var shouldMock: Bool {
        Container.shared.resolve(Bool.self, name: "shoudMock") ?? false
    }
    
    func activateMock(_ isActivate: Bool) {
        Container.shared.register(Networking.self) { _ in
            ApiClientMock()
        }
    }
}

class GenericTableViewModel<ViewModel>: DataSourced, Mockable {
    
    let dataSource: BehaviorRelay<[ViewModel]> = BehaviorRelay(value: [])
    let isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let hasError: BehaviorRelay<BnpError?> = BehaviorRelay(value: nil)
    let reload: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
        //internal var shouldMock: Bool = false
    
    func activateMock(_ isActivated: Bool) {
        let currentShouldMock = shouldMock
        Container.shared.register(Bool.self, name: "shoudMock") { _ in
            return !currentShouldMock
        }.inObjectScope(.container)
        
        print("**🔥**", "shouldMock", shouldMock)
        let apiCLient: Networking = shouldMock ? ApiClientMock() : ApiClient()
        Container.shared.register(Networking.self) { _ in
            return apiCLient
        }
        
        reload.accept(true)
        
    }
}
