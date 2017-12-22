//
//  ImageLoadingServiceMock.swift
//  MovieSearchTests
//
//  Created by Andrii Kravchenko on 22.12.17.
//

import UIKit
@testable import MovieSearch

class ImageLoadingServiceMock: ImageLoadingServiceProtocol {
    var success = true
    
    func loadImage(name: String?, scale: ImageScale, completion: @escaping ((UIImage?, Error?) -> Void)) {
        completion(success ? UIImage() : nil, success ? nil : ParsingError.noData)
    }
}
