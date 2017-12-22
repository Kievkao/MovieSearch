//
//  SearchViewModelTests.swift
//  MovieSearchTests
//
//  Created by Andrii Kravchenko on 22.12.17.
//

import XCTest
import RxSwift
@testable import MovieSearch

class SearchViewModelTests: XCTestCase {
    var disposeBag: DisposeBag!
    
    var storage: StorageMock!
    var connectivity: ConnectivityMock!
    var viewModel: SearchViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        
        storage = StorageMock()
        connectivity = ConnectivityMock()
        
        let serviceFactory = NetworkServiceFactoryMock()
        let handlers = SearchViewModel.HandlersContainer(searchFinished: {_,_ in })
        
        viewModel = SearchViewModel(storage: storage, serviceFactory: serviceFactory, connectivity: connectivity, handlers: handlers)
        disposeBag = DisposeBag()
    }
    
    func testSetup() {
        XCTAssertTrue(viewModel.items.value.isEmpty)
    }
    
    func testAvailableHistory() {
        let exp = expectation(description: "History loaded")
        
        storage.success = true
        viewModel.items.asObservable().skip(1).subscribe(onNext: { items in
            XCTAssertEqual(items.count, 2)
            exp.fulfill()
        }).disposed(by: disposeBag)
        
        viewModel.retrieveHistory()
        waitForExpectations(timeout: 0.5)
    }
    
    func testEmptyHistory() {
        let exp = expectation(description: "History loaded")
        
        storage.success = false
        viewModel.items.asObservable().skip(1).subscribe(onNext: { items in
            XCTAssertTrue(items.isEmpty)
            exp.fulfill()
        }).disposed(by: disposeBag)
        
        viewModel.retrieveHistory()
        waitForExpectations(timeout: 0.5)
    }
    
    func testSearchNoInternet() {
        let exp = expectation(description: "Error sent")
        
        connectivity.isConnected = false
        
        viewModel.errorSubject.subscribe(onNext: { error in
            XCTAssertEqual(error, SearchError.noInternet.localizedDescription)
            exp.fulfill()
        }).disposed(by: disposeBag)
        
        viewModel.search("Batman")
        
        waitForExpectations(timeout: 0.5)
    }
    
    func testSearchWithInternet() {
        let progressOnExp = expectation(description: "Progress set")
        let progressOffExp = expectation(description: "Progress cleared")
        
        connectivity.isConnected = true
        
        viewModel.progressSubject.subscribe(onNext: { inProgress in
            if inProgress {
                progressOnExp.fulfill()
            } else {
                progressOffExp.fulfill()
            }
        }).disposed(by: disposeBag)
        
        viewModel.search("Batman")
        
        waitForExpectations(timeout: 0.5)
    }
}
