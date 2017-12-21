//
//  AppDelegate.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var flowController: MainFlowController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        guard let navigation = window?.rootViewController as? UINavigationController else { return false }
        startMainFlow(navigation: navigation)
        return true
    }
    
    private func startMainFlow(navigation: UINavigationController) {
        let storage = CoreDataStorage()
        let config = ConfigurationProvider()
        let serviceFactory = NetworkServiceFactory(config: config)
        flowController = MainFlowController(navigation: navigation, storage: storage, serviceFactory: serviceFactory)
        flowController.start()
    }
}

