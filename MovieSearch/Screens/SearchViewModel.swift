//
//  SearchViewModel.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import Foundation

protocol SearchViewModelProtocol {
    var items: [String] { get }

    var remainedCellsBeforeLoadMore: Int { get }
}

class SearchViewModel: SearchViewModelProtocol {
    let remainedCellsBeforeLoadMore = 5
    
    var items = [String]()
    
    private let storage: Storage
    private let searchService: SearchServiceProtocol
    
    init(storage: Storage, serviceFactory: NetworkServiceFactory) {
        self.storage = storage
        self.searchService = serviceFactory.searchService()
    }
    
    func search(_ query: String) {
        let request = searchService.searchMovieRequest(query: query, page: 0)
    }
}
