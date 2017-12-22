//
//  SearchServiceMock.swift
//  MovieSearchTests
//
//  Created by Andrii Kravchenko on 22.12.17.
//

import Foundation
@testable import MovieSearch

class SearchServiceMock: SearchServiceProtocol {
    var success = true
    
    func searchMovie(_ query: String, page: Int, completion: @escaping ([Movie]?, Error?) -> Void) {
        completion(success ? [Movie.stubInstance(), Movie.stubInstance()] : nil, success ? nil : ParsingError.jsonCast)
    }
}
