//
//  Configuration.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import Foundation

protocol Configuration {
    var host: String { get }
    var hostVersion: String { get }
    var scheme: String { get }
    var apiKey: String { get }
}

class ConfigurationProvider: Configuration {
    lazy var configDict: [String: AnyObject] = {
        let plistPath = Bundle.main.path(forResource: "Info", ofType: "plist")!
        let plistData = FileManager.default.contents(atPath: plistPath)!
        var format = PropertyListSerialization.PropertyListFormat.xml
        return try! PropertyListSerialization.propertyList(from: plistData, options: .mutableContainersAndLeaves, format: &format) as! [String : AnyObject]
    }()
    
    var host: String {
        return configDict["host"] as! String
    }
    
    var hostVersion: String {
        return configDict["hostVersion"] as! String
    }
    
    var scheme: String {
        return configDict["scheme"] as! String
    }
    
    var apiKey: String {
        return configDict["apiKey"] as! String
    }
}
