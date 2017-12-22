//
//  SearchViewModelTests.swift
//  MovieSearchTests
//
//  Created by Andrii Kravchenko on 22.12.17.
//

import XCTest
@testable import MovieSearch

class SearchViewModelTests: XCTestCase {
    var viewModel: SearchViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        
        let storage = StorageMock()
        let serviceFactory = NetworkServiceFactoryMock()
        let connectivity = ConnectivityMock()
        
        let handlers = SearchViewModel.HandlersContainer(searchFinished: { query, movies in
            
        })
        
        viewModel = SearchViewModel(storage: storage, serviceFactory: serviceFactory, connectivity: connectivity, handlers: handlers)
    }
}
