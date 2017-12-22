//
//  SearchMock.swift
//  MovieSearchTests
//
//  Created by Andrii Kravchenko on 22.12.17.
//

import Foundation
@testable import MovieSearch

extension Search {
    static func stubInstance() -> Search {
        return Search(query: "Batman")
    }
}
