//
//  MovieCellViewModel.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import UIKit
import RxSwift

protocol MovieCellViewModelProtocol {
    var name: String? { get }
    var releaseDate: String? { get }
    var overview: String? { get }    
    var poster: Variable<UIImage?> { get }
    
    func loadImage()
}

class MovieCellViewModel: MovieCellViewModelProtocol {
    private let movie: Movie
    private let imageLoadingService: ImageLoadingServiceProtocol
    
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
    
    let poster = Variable<UIImage?>(nil)

    init(movie: Movie, serviceFactory: NetworkServiceFactoryProtocol) {
        self.movie = movie
        self.imageLoadingService = serviceFactory.imageLoadingService()
    }
    
    func loadImage() {
        imageLoadingService.loadImage(name: movie.posterPath, scale: .small) { [weak self] image, error in
            self?.poster.value = image
        }
    }
}
