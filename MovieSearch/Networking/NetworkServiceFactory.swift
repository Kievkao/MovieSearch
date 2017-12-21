//
//  NetworkRouterFactory.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import Foundation

enum APIPath: String {
    case search = "/search/movie"
}

enum ResponseError: Error, CustomStringConvertible {
    case parseError
    
    var description: String {
        switch self {
        case .parseError: return "Unable to parse response"
        }
    }
}

class NetworkServiceFactory {
    private let config: Configuration
    
    init(config: Configuration) {
        self.config = config
    }
    
    func searchService() -> SearchServiceProtocol {
        let router = NetworkRouter(config: config, path: .search)
        return SearchService(router: router)
    }
}
