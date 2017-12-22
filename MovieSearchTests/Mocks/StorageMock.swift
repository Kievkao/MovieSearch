//
//  StorageMock.swift
//  MovieSearchTests
//
//  Created by Andrii Kravchenko on 22.12.17.
//

import Foundation
@testable import MovieSearch

class StorageMock: Storage {
    var success = true
    
    func save(search: String, keepCapacity: Int, completion: ((Bool) -> Void)?) {
        completion?(success)
    }
    
    func getLastSearches(sorting: Sorting, completion: (([Search]) -> Void)) {
        completion(success ? [Search.stubInstance(), Search.stubInstance()] : [])
    }
}
