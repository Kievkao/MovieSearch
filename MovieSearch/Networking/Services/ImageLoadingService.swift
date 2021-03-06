//
//  ImageLoadingService.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 22.12.17.
//

import UIKit
import Alamofire
import AlamofireImage

enum ImageScale: String {
    case small = "w92"
    case medium = "w185"
    case large = "w500"
    case original = "w780"
}

/**
 ImageLoadingServiceProtocol is an interface of object to retrieve images from defined host by the name
 
 - func loadImage(): retrieve an image by it's name and provided scale
 */
protocol ImageLoadingServiceProtocol {
    func loadImage(name: String?, scale: ImageScale, completion: @escaping ((UIImage?, Error?) -> Void))
}

final class ImageLoadingService: ImageLoadingServiceProtocol {
    private let router: APIRouterProtocol
    let downloader = ImageDownloader(
        configuration: ImageDownloader.defaultURLSessionConfiguration(),
        downloadPrioritization: .fifo,
        maximumActiveDownloads: 4,
        imageCache: AutoPurgingImageCache()
    )
    
    init(router: APIRouterProtocol) {
        self.router = router
    }
    
    func loadImage(name: String?, scale: ImageScale, completion: @escaping ((UIImage?, Error?) -> Void)) {
        guard let name = name, let request = router.imageRequest(imageName: name, scale: scale) else { return }
        
        downloader.download(request) { response in
            let error = response.error
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let image = response.result.value else {
                completion(nil, ParsingError.noData)
                return
            }
            
            completion(image, nil)
        }
    }
}
