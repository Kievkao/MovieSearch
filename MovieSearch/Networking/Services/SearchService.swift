//
//  SearchRouter.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import Foundation
import Alamofire

protocol SearchServiceProtocol {
    func searchMovie(_ query: String, page: Int, completion: @escaping ([Movie]?, Error?) -> Void)
}

class SearchService: SearchServiceProtocol {
    private let router: APIRouter
    
    init(router: APIRouter) {
        self.router = router
    }
    
    func searchMovie(_ query: String, page: Int, completion: @escaping ([Movie]?, Error?) -> Void) {
        guard let request = router.request(method: .get, params: ["query": query, "page": String(page)]) else { return }
        
        Alamofire.request(request).responseJSON { response in
            let error = response.error
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let json = response.result.value as? [String: AnyObject] else {
                completion(nil, ParsingError.jsonCast)
                return
            }
            
            guard let results = json["results"] as? [[String: AnyObject]] else {
                completion(nil, ParsingError.responseStructure)
                return
            }
            
            completion(results.map { Movie(json: $0) }, nil)
        }
    }
}
