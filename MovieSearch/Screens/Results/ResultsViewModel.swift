//
//  ResultsViewModel.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import Foundation

import Foundation

protocol SearchResultsViewModelProtocol {
    var items: [Movie] { get }
}

class SearchResultsViewModel: SearchResultsViewModelProtocol {
    var items = [Movie]()
    
    private let searchService: SearchServiceProtocol
    
    init(serviceFactory: NetworkServiceFactory) {
        self.searchService = serviceFactory.searchService()
    }
}
