//
//  ResultsViewModelTests.swift
//  MovieSearchTests
//
//  Created by Andrii Kravchenko on 22.12.17.
//

import XCTest
@testable import MovieSearch

class ResultsViewModelTests: XCTestCase {
    var viewModel: ResultsViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        
        let serviceFactory = NetworkServiceFactoryMock()
        let connectivity = ConnectivityMock()
        
        viewModel = ResultsViewModel(searchQuery: "Batman", initialResults: [Movie.stubInstance()], serviceFactory: serviceFactory, connectivity: connectivity)
    }
}
