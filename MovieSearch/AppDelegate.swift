//
//  AppDelegate.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var flowController: MainFlowController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        guard let navigation = window?.rootViewController as? UINavigationController else { return false }
        setupAppearance()
        startMainFlow(navigation: navigation)
        return true
    }
    
    private func startMainFlow(navigation: UINavigationController) {
        let storage = CoreDataStorage()
        let config = ConfigurationProvider()
        let serviceFactory = NetworkServiceFactory(config: config)
        let connectivity = ConnectivityHandler(reachability: NetworkReachabilityManager())
        
        flowController = MainFlowController(navigation: navigation, storage: storage, serviceFactory: serviceFactory, connectivity: connectivity)
        flowController.start()
    }
    
    private func setupAppearance() {
        UIApplication.shared.statusBarStyle = .lightContent
        
        UINavigationBar.appearance().barTintColor = UIColor.navigationBarColor()
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20.0)]

        UISearchBar.appearance().tintColor = UIColor.navigationBarColor()
    }
}

