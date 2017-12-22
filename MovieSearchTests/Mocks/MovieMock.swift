//
//  MovieMock.swift
//  MovieSearchTests
//
//  Created by Andrii Kravchenko on 22.12.17.
//

import Foundation
@testable import MovieSearch

extension Movie {
    static func stubInstance() -> Movie {
        return Movie(json: Movie.mockJSON as [String: AnyObject])
    }
    
    private static let mockJSON: [String: String] = [
        "poster_path": "2DtPSyODKWXluIRV7PVru0SSzja.jpg",
        "overview": "Amazing movie",
        "title": "Movie name",
        "release_date": "2017-01-12"
    ]
}

