//
//  APIRouterMock.swift
//  MovieSearchTests
//
//  Created by Andrii Kravchenko on 22.12.17.
//

import Foundation
@testable import MovieSearch

class APIRouterMock: APIRouterProtocol {
    func request(method: RESTMethod, params: [String: String]) -> URLRequest? {
        return nil
    }
    
    func imageRequest(imageName: String, scale: ImageScale) -> URLRequest? {
        return nil
    }
}
