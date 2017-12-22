//
//  ConnectivityMock.swift
//  MovieSearchTests
//
//  Created by Andrii Kravchenko on 22.12.17.
//

import Foundation
@testable import MovieSearch

class ConnectivityMock: Connectivity {
    var isConnected = true
    
    var isInternetConnected: Bool { return isConnected }
}
