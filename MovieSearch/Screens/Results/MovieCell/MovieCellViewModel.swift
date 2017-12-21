//
//  MovieCellViewModel.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import Foundation

protocol MovieCellViewModelProtocol {
    var name: String? { get }
    var releaseDate: String? { get }
    var overview: String? { get }
}

class MovieCellViewModel: MovieCellViewModelProtocol {
    private let movie: Movie
    
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter
    }()
    
    var name: String? { return movie.name }
    var overview: String? { return movie.overview }
    var releaseDate: String? {
        guard let date = movie.releaseDate else { return nil }
        return MovieCellViewModel.dateFormatter.string(from: date)
    }

    init(movie: Movie) {
        self.movie = movie
    }
}
