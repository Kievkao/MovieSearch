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

enum ParsingError: Error, CustomStringConvertible {
    case jsonCast
    case responseStructure
    case noData
    
    var description: String {
        switch self {
        case .jsonCast: return "Convert to JSON error".localized()
        case .responseStructure: return "Unable to parse response".localized()
        case .noData: return "No expected response data".localized()
        }
    }
}

class NetworkServiceFactory {
    private let config: Configuration
    
    init(config: Configuration) {
        self.config = config
    }
    
    func searchService() -> SearchServiceProtocol {
        let router = APIRouter(config: config, path: .search)
        return SearchService(router: router)
    }
    
    func imageLoadingService() -> ImageLoadingService {
        let router = APIRouter(config: config, path: .images)
        return ImageLoadingService(router: router)
    }
}
