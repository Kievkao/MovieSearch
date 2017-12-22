//
//  ImageLoadingServiceTests.swift
//  MovieSearchTests
//
//  Created by Andrii Kravchenko on 22.12.17.
//

import XCTest
@testable import MovieSearch

class ImageLoadingServiceTests: XCTestCase {
    var service: ImageLoadingServiceProtocol!
    
    override func setUp() {
        super.setUp()
        
        let router = APIRouterMock()
        service = ImageLoadingService(router: router)
    }
}
