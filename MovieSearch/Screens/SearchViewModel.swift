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
}
