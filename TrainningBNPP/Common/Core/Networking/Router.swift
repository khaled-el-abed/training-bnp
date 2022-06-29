//
//  Router.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 21/06/2022.
//

import Foundation
import Swinject

//https://api.themoviedb.org/3/search/movie?api_key=d2ba8efad713816aeac0d732d7cbaca8&language=en-US&query=Fight%20club&page=1&include_adult=false

enum Router {
    enum Path {
        static let  movies = "movie"

    }

    static var baseUrl: String {
        "https://api.themoviedb.org/3/search/"
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol RequestProtocol {
    var url: String { get }
    var urlString: String { get }
    var method: HttpMethod { get }
    var urlRequest: URLRequest { get }
}

extension RequestProtocol {

    var urlRequest: URLRequest {
        guard  let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                       let url = URL(string: encodedUrl) else {
                    preconditionFailure("Invalid URL used to create URL instance")
                }

        return URLRequest(url: url)

    }

    var configuration: ApiConfiguration {
        Container.shared.resolve(ApiConfiguration.self)!
    }
    
    var url: String {
        let url = "\(Router.baseUrl)\(urlString)" + "&api_key=\(configuration.authrizationKey)&language=\(configuration.language)"
        return url
    }
}
