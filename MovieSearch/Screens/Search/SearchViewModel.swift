//
//  SearchViewModel.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import Foundation
import RxSwift

protocol SearchViewModelProtocol {
    var items: Variable<[Search]> { get }
    
    func retrieveHistory()
    func hideHistory()
    func search(_ query: String)
}

class SearchViewModel: SearchViewModelProtocol {
    struct HandlersContainer {
        let searchFinished: ([Movie]) -> Void
    }
    
    private static let historyCapasity = 10
    
    var items = Variable<[Search]>([])
    
    private let storage: Storage
    private let searchService: SearchServiceProtocol
    private let handlers: HandlersContainer
    
    init(storage: Storage, serviceFactory: NetworkServiceFactory, handlers: HandlersContainer) {
        self.storage = storage
        self.searchService = serviceFactory.searchService()
        self.handlers = handlers
    }
    
    func retrieveHistory() {
        storage.getLastSearches(sorting: .date(ascending: false)) { [weak self] searches in
            self?.items.value = searches
        }
    }
    
    func hideHistory() {
        
    }
    
    func search(_ query: String) {
        searchService.searchMovie(query, page: 1) { [weak self] movies, error in
            guard error == nil, let movies = movies else { return }
            
            self?.storage.save(search: query, keepCapacity: SearchViewModel.historyCapasity, completion: nil)
            self?.handlers.searchFinished(movies)
        }
    }
}
