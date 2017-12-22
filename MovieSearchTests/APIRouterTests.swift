//
//  APIRouterTests.swift
//  MovieSearchTests
//
//  Created by Andrii Kravchenko on 22.12.17.
//

import XCTest
@testable import MovieSearch

class APIRouterTests: XCTestCase {
    var router: APIRouterProtocol!
    
    override func setUp() {
        super.setUp()
        
        let config = ConfigurationMock()
        router = APIRouter(config: config, path: .search)
    }
}
