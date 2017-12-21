//
//  NetworkServiceFactory.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import Foundation

protocol NetworkServiceFactory {
    func searchService() -> SearchServiceProtocol
}

class MoviesServiceFactory: NetworkServiceFactory {
    private let config: Configuration
    
    init(config: Configuration) {
        self.config = config
    }
    func searchService() -> SearchServiceProtocol {
        return SearchService(config: config, path: .search)
    }
}
