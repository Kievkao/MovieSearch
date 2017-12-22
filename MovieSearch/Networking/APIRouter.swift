//
//  APIRouter.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import Foundation

class APIRouter {
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    private let config: Configuration
    private let path: APIPath
    
    init(config: Configuration, path: APIPath) {
        self.config = config
        self.path = path
    }
    
    func request(method: Method, params: [String: String]) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = config.scheme
        urlComponents.host = config.host
        urlComponents.path = config.hostStartPath + path.rawValue
        
        var queryItems = [URLQueryItem(name: "api_key", value: config.apiKey)]
        
        queryItems.append(contentsOf: params.map {
            URLQueryItem(name: $0.0, value: $0.1)
        })        
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue        
        return urlRequest
    }
}

extension APIRouter {
    func imageRequest(imageName: String, scale: ImageScale) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = config.imagesScheme
        urlComponents.host = config.imagesHost
        urlComponents.path = path.rawValue + scale.rawValue + imageName
        
        guard let url = urlComponents.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = Method.get.rawValue
        return urlRequest
    }
}
