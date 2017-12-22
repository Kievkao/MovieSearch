//
//  Connectivity.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 22.12.17.
//

import Alamofire

/**
 Connectivity is an interface of an object which detect internet connection availability
 
 - isInternetConnected: bool value which shows current internet status (connected/disconnected)
 */
protocol Connectivity {
    var isInternetConnected: Bool { get }
}

final class ConnectivityHandler: Connectivity {
    let reachability: NetworkReachabilityManager?
    
    init(reachability: NetworkReachabilityManager?) {
        self.reachability = reachability
    }
    
    var isInternetConnected: Bool {
        return reachability?.isReachable ?? false
    }
}
