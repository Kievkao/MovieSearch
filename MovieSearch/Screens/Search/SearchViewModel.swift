//
//  SearchViewModel.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import Foundation
import RxSwift

/**
 SearchViewModelProtocol is an interface of view model for searching movies
 - items: saved previous search queries, if retrieveHistory() was called before
 - errorSubject: signal for emiting errors during search
 - progressSubject: signal for emiting loading state changes
 
 - func retrieveHistory(): retrieve previous successed search queries and put them to 'items' variable
 - func hideHistory(): clear 'items' variable value
 - func search(_ query: String): perform a search based on passed query string
 */
protocol SearchViewModelProtocol {
    var items: Variable<[Search]> { get }
    var errorSubject: PublishSubject<String> { get }
    var progressSubject: PublishSubject<Bool> { get }
    
    func retrieveHistory()
    func hideHistory()
    func search(_ query: String)
}

enum SearchError: Error {
    case noResults
    case noInternet
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .noResults: return "No movies by request".localized()
        case .noInternet: return "No Internet connection".localized()
        case .unknownError: return "Unknown Error".localized()
        }
    }
}

final class SearchViewModel: SearchViewModelProtocol {
    struct HandlersContainer {
        let searchFinished: (String, [Movie]) -> Void
    }
    
    private static let historyCapasity = 10
    
    let items = Variable<[Search]>([])
    let errorSubject = PublishSubject<String>()
    let progressSubject = PublishSubject<Bool>()
    
    private let storage: Storage
    private let searchService: SearchServiceProtocol
    private let connectivity: Connectivity
    private let handlers: HandlersContainer
    
    init(storage: Storage, serviceFactory: NetworkServiceFactoryProtocol, connectivity: Connectivity, handlers: HandlersContainer) {
        self.storage = storage
        self.searchService = serviceFactory.searchService()
        self.connectivity = connectivity
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
        guard connectivity.isInternetConnected else {
            errorSubject.onNext(SearchError.noInternet.localizedDescription)
            return
        }
        
        progressSubject.onNext(true)
        
        searchService.searchMovie(query, page: 1) { [weak self] movies, error in
            defer { self?.progressSubject.onNext(false) }
            guard let strongSelf = self else { return }
            
            guard error == nil, let movies = movies, !movies.isEmpty else {
                strongSelf.errorSubject.onNext(SearchError.noResults.localizedDescription)
                return
            }
            
            strongSelf.storage.save(search: query, keepCapacity: SearchViewModel.historyCapasity, completion: nil)
            strongSelf.handlers.searchFinished(query, movies)
        }
    }
}
