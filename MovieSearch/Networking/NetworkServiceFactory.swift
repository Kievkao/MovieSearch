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

enum ParsingError: Error, CustomStringConvertible {
    case jsonCast
    case responseStructure
    
    var description: String {
        switch self {
        case .jsonCast: return "Convert to JSON error".localized()
        case .responseStructure: return "Unable to parse response".localized()
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
