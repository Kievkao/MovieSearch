//
//  Movie.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import Foundation

class Movie {
    var name: String?
    var releaseDate: Date?
    var overview: String?
    var posterPath: String?
    
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    init(json: [String: AnyObject]) {
        posterPath = json["poster_path"] as? String
        overview = json["overview"] as? String
        name = json["title"] as? String
        releaseDate = (json["release_date"] as? String).flatMap { Movie.dateFormatter.date(from: $0) }
    }
}
