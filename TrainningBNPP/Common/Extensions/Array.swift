//
//  Array.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 24/06/2022.
//

import Foundation

extension Array where Iterator.Element == URLQueryItem {
    subscript(_ key: String) -> String? {
        return first(where: { $0.name == key })?.value
    }
}
