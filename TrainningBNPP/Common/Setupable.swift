//
//  Setupable.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 22/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

protocol Setupable {
     associatedtype ViewModel
 
    func setup(with model: ViewModel)
 }
