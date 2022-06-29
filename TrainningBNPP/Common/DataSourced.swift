//
//  DataSourced.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 28/06/2022.
//

import RxSwift
import RxCocoa
import UIKit

protocol DataSourced {
   associatedtype ViewModel
    
   var dataSource: BehaviorRelay<[ViewModel]> { get }
}
