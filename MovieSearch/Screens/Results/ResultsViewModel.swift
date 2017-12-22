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
    var isDataLoading: Bool { get }
    var errorSubject: PublishSubject<String> { get }
    var serviceFactory: NetworkServiceFactory { get }
    
    func loadNextPage()
}

class SearchResultsViewModel: SearchResultsViewModelProtocol {
    let items: Variable<[Movie]>
    let serviceFactory: NetworkServiceFactory
    let errorSubject = PublishSubject<String>()
    
    private let searchService: SearchServiceProtocol
    private let connectivity: Connectivity
    
    private let searchQuery: String
    private var nextPage: Int = 2
    
    var isDataLoading: Bool = false
    
    init(searchQuery: String, initialResults: [Movie], serviceFactory: NetworkServiceFactory, connectivity: Connectivity) {
        self.searchQuery = searchQuery
        self.items = Variable<[Movie]>(initialResults)
        self.serviceFactory = serviceFactory
        self.searchService = serviceFactory.searchService()
        self.connectivity = connectivity
    }
    
    func loadNextPage() {
        guard connectivity.isInternetConnected else {
            errorSubject.onNext(SearchError.noInternet.localizedDescription)
            return
        }
        
        isDataLoading = true
        
        searchService.searchMovie(searchQuery, page: nextPage) { [weak self] movies, error in
            defer { self?.isDataLoading = false }            
            guard let strongSelf = self, error == nil, let movies = movies, !movies.isEmpty else { return }
            
            strongSelf.items.value.append(contentsOf: movies)
            strongSelf.nextPage += 1
        }
    }
}
