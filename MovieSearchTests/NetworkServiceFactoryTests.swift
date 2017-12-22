//
//  NetworkServiceFactoryTests.swift
//  MovieSearchTests
//
//  Created by Andrii Kravchenko on 22.12.17.
//

import XCTest
@testable import MovieSearch

class NetworkServiceFactoryTests: XCTestCase {
    var factory: NetworkServiceFactoryProtocol!
    
    override func setUp() {
        super.setUp()
        
        let config = ConfigurationMock()
        factory = NetworkServiceFactory(config: config)
    }
}
