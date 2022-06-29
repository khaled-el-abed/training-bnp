//
//  MoviesServiceMock.swift
//  TrainningBNPPTests
//
//  Created by Khaled El Abed on 27/06/2022.
//

import Foundation

@testable import TrainningBNPP

final class MovieServiceMock: MovieServiceProtocol {
    
    var callCount: Int = 0
    
    init() {
        print("**🔥**", type(of: self), #function)
    }
    func fetchMovie(by name: String, completion: @escaping(Result<MovieResponse, BnpError>) -> Void) {
        callCount += 1
        print("**🔥**", type(of: self), #function, "callCount \(callCount)", Unmanaged.passUnretained(self).toOpaque()  )
        completion(.success(MockHelper.getMovieResponse()))
    }
}


func addressOf<T: AnyObject>(_ o: T) -> String {
    let addr = unsafeBitCast(o, to: Int.self)
    return String(format: "%p", addr)
}
