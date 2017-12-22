//
//  SearchServiceTests.swift
//  MovieSearchTests
//
//  Created by Andrii Kravchenko on 22.12.17.
//

import XCTest
@testable import MovieSearch

class SearchServiceTests: XCTestCase {
    var service: SearchServiceProtocol!
    
    override func setUp() {
        super.setUp()
        
        let router = APIRouterMock()
        service = SearchService(router: router)
    }
}
