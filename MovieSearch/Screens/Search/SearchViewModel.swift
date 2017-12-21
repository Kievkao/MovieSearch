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
    var errorSubject: PublishSubject<String> { get }
    var progressSubject: PublishSubject<Bool> { get }
    
    func retrieveHistory()
    func hideHistory()
    func search(_ query: String)
}

enum SearchError: Error, CustomStringConvertible {
    case noResults
    case unknownError
    
    var description: String {
        switch self {
        case .noResults: return "No movies by request".localized()
        case .unknownError: return "Unknown Error".localized()
        }
    }
}

class SearchViewModel: SearchViewModelProtocol {
    struct HandlersContainer {
        let searchFinished: ([Movie]) -> Void
    }
    
    private static let historyCapasity = 10
    
    var items = Variable<[Search]>([])
    var errorSubject = PublishSubject<String>()
    var progressSubject = PublishSubject<Bool>()
    
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
        items.value = []
    }
    
    func search(_ query: String) {
        progressSubject.onNext(true)
        
        searchService.searchMovie(query, page: 1) { [weak self] movies, error in
            defer { self?.progressSubject.onNext(false) }
            
            if let error = error {
                self?.errorSubject.onNext(error.localizedDescription)
                return
            }
            
            guard let movies = movies else {
                self?.errorSubject.onNext(SearchError.unknownError.localizedDescription)
                return
            }
            
            guard !movies.isEmpty else {
                self?.errorSubject.onNext(SearchError.noResults.localizedDescription)
                return
            }
            
            self?.storage.save(search: query, keepCapacity: SearchViewModel.historyCapasity, completion: nil)
            self?.handlers.searchFinished(movies)
        }
    }
}
