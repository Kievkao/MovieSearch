//
//  ConfigurationMock.swift
//  MovieSearchTests
//
//  Created by Andrii Kravchenko on 22.12.17.
//

import Foundation
@testable import MovieSearch

class ConfigurationMock: Configuration {
    var host: String = "google.com"
    var hostStartPath: String = "/3"
    var scheme: String = "https"
    var apiKey: String = "key"
    
    var imagesHost: String = "images.com"
    var imagesScheme: String = "http"
}
