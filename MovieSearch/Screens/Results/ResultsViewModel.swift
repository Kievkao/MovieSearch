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
    private let searchService: SearchServiceProtocol
    
    private let searchQuery: String
    private var nextPage: Int = 2
    
    var isDataLoading: Bool = false
    
    init(searchQuery: String, initialResults: [Movie], serviceFactory: NetworkServiceFactory) {
        self.searchQuery = searchQuery
        self.items = Variable<[Movie]>(initialResults)
        self.serviceFactory = serviceFactory
        self.searchService = serviceFactory.searchService()
    }
    
    func loadNextPage() {
        isDataLoading = true
        
        searchService.searchMovie(searchQuery, page: nextPage) { [weak self] movies, error in
            defer { self?.isDataLoading = false }
            
            if let error = error {
                self?.errorSubject.onNext(error.localizedDescription)
                return
            }
            
            guard let movies = movies, !movies.isEmpty else { return }
            self?.items.value.append(contentsOf: movies)
            self?.nextPage += 1
        }
    }
}
