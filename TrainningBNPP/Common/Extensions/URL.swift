//
//  URL.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 24/06/2022.
//

import Foundation

extension URL {
    var components: URLComponents? {
        return URLComponents(url: self, resolvingAgainstBaseURL: false)
    }
}
