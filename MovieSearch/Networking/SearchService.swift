//
//  SearchService.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import Foundation

protocol SearchServiceProtocol {
    func searchMovieRequest(query: String, page: Int) -> URLRequest?
}

final class SearchService: NetworkService, SearchServiceProtocol {
    func searchMovieRequest(query: String, page: Int) -> URLRequest? {
        return request(method: .get, params: ["query": query, "page": String(page)])
    }
}
