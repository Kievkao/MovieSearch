//
//  MovieTests.swift
//  MovieSearchTests
//
//  Created by Andrii Kravchenko on 22.12.17.
//

import XCTest
@testable import MovieSearch

class MovieTests: XCTestCase {
    func testFullSetup() {
        let correctJSON: [String: String] = [
            "poster_path": "2DtPSyODKWXluIRV7PVru0SSzja.jpg",
            "overview": "Amazing movie",
            "title": "Movie name",
            "release_date": "2017-01-12"
        ]
        
        let movie = Movie(json: correctJSON as [String : AnyObject])
        XCTAssertEqual(movie.posterPath, correctJSON["poster_path"])
        XCTAssertEqual(movie.overview, correctJSON["overview"])
        XCTAssertEqual(movie.name, correctJSON["title"])
        XCTAssertEqual(movie.releaseDate?.timeIntervalSince1970, 1484175600)
    }
    
    func testIncorrectDateSetup() {
        let correctJSON: [String: String] = [
            "poster_path": "2DtPSyODKWXluIRV7PVru0SSzja.jpg",
            "overview": "Amazing movie",
            "title": "Movie name",
            "release_date": "Hello"
        ]
        
        let movie = Movie(json: correctJSON as [String : AnyObject])
        XCTAssertEqual(movie.posterPath, correctJSON["poster_path"])
        XCTAssertEqual(movie.overview, correctJSON["overview"])
        XCTAssertEqual(movie.name, correctJSON["title"])
        XCTAssertNil(movie.releaseDate)
    }
}
