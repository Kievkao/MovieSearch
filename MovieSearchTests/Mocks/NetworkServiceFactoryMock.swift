//
//  NetworkServiceFactoryMock.swift
//  MovieSearchTests
//
//  Created by Andrii Kravchenko on 22.12.17.
//

import Foundation
@testable import MovieSearch

class NetworkServiceFactoryMock: NetworkServiceFactoryProtocol {
    func searchService() -> SearchServiceProtocol {
        return SearchServiceMock()
    }
    
    func imageLoadingService() -> ImageLoadingServiceProtocol {
        return ImageLoadingServiceMock()
    }
}
