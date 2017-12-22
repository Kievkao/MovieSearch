//
//  ResultsViewModelTests.swift
//  MovieSearchTests
//
//  Created by Andrii Kravchenko on 22.12.17.
//

import XCTest
import RxSwift
@testable import MovieSearch

class ResultsViewModelTests: XCTestCase {
    var disposeBag: DisposeBag!
    
    var viewModel: ResultsViewModelProtocol!
    var connectivity: ConnectivityMock!
    
    override func setUp() {
        super.setUp()
        
        let serviceFactory = NetworkServiceFactoryMock()
        connectivity = ConnectivityMock()
        
        viewModel = ResultsViewModel(searchQuery: "Batman", initialResults: [Movie.stubInstance()], serviceFactory: serviceFactory, connectivity: connectivity)
        disposeBag = DisposeBag()
    }
    
    func testSetup() {
        XCTAssertFalse(viewModel.items.value.isEmpty)
        XCTAssertFalse(viewModel.isDataLoading)
    }
    
    func testLoadingWithInternet() {
        let exp = expectation(description: "Data loaded")
        
        viewModel.items.asObservable().skip(1).subscribe(onNext: { movies in
            exp.fulfill()
        }).disposed(by: disposeBag)
        
        connectivity.isConnected = true
        viewModel.loadNextPage()
        
        waitForExpectations(timeout: 0.5)
    }
    
    func testLoadingWithoutInternet() {
        let exp = expectation(description: "Error sent")
        
        connectivity.isConnected = false
        
        viewModel.errorSubject.subscribe(onNext: { error in
            XCTAssertEqual(error, SearchError.noInternet.localizedDescription)
            exp.fulfill()
        }).disposed(by: disposeBag)
        
        viewModel.loadNextPage()
        
        waitForExpectations(timeout: 0.5)
    }
}
