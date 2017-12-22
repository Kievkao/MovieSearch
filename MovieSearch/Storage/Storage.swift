//
//  Storage.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import Foundation

enum Sorting {
    case alphabetical(ascending: Bool)
    case date(ascending: Bool)
}

/**
 Storage is an interface of an object which provides local storage for data
 
 - func save(): save string search query, keeping count of max possible saved objects
 - func getLastSearches(): retrieve saved search queries
 */
protocol Storage {
    func save(search: String, keepCapacity: Int, completion: ((Bool) -> Void)?)
    func getLastSearches(sorting: Sorting, completion: (([Search]) -> Void))
}
