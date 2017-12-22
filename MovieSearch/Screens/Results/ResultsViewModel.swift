//
//  ResultsViewModel.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import Foundation
import RxSwift

protocol SearchResultsViewModelProtocol {
    var items: Variable<[Movie]> { get }
    var errorSubject: PublishSubject<String> { get }
    var isDataLoading: Bool { get }
    var serviceFactory: NetworkServiceFactory { get }
    
    func loadNextPage()
}

class SearchResultsViewModel: SearchResultsViewModelProtocol {
    let items: Variable<[Movie]>
    let errorSubject = PublishSubject<String>()
    let serviceFactory: NetworkServiceFactory
    
    private let searchQuery: String
    private var currentPage: Int = 0
    
    var isDataLoading: Bool = false
    
    init(searchQuery: String, initialResults: [Movie], serviceFactory: NetworkServiceFactory) {
        self.searchQuery = searchQuery
        self.items = Variable<[Movie]>(initialResults)
        self.serviceFactory = serviceFactory
    }
    
    func loadNextPage() {
        isDataLoading = true
    }
}
