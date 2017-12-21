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

protocol Storage {
    func save(search: String, keepCapacity: Int, completion: ((Bool) -> Void)?)
    func getLastSearches(sorting: Sorting, completion: (([Search]) -> Void))
}
