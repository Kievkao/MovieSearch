//
//  APIRouterFactory.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import Foundation

enum APIPath: String {
    case search = "/search/movie"
    case images = "/t/p/"
}

enum ParsingError: Error {
    case jsonCast
    case responseStructure
    case noData
    
    var localizedDescription: String {
        switch self {
        case .jsonCast: return "Convert to JSON error".localized()
        case .responseStructure: return "Unable to parse response".localized()
        case .noData: return "No expected response data".localized()
        }
    }
}

/**
 NetworkServiceFactoryProtocol is an interface of an object which creates needed network services
 
 - func searchService(): create service for movies searching
 - func imageLoadingService(): create service for movies posters loading
 */
protocol NetworkServiceFactoryProtocol {
    func searchService() -> SearchServiceProtocol
    func imageLoadingService() -> ImageLoadingServiceProtocol
}

final class NetworkServiceFactory: NetworkServiceFactoryProtocol {
    private let config: Configuration
    
    init(config: Configuration) {
        self.config = config
    }
    
    func searchService() -> SearchServiceProtocol {
        let router = APIRouter(config: config, path: .search)
        return SearchService(router: router)
    }
    
    func imageLoadingService() -> ImageLoadingServiceProtocol {
        let router = APIRouter(config: config, path: .images)
        return ImageLoadingService(router: router)
    }
}
