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
    var flowController: FlowController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        guard let navigation = window?.rootViewController as? UINavigationController else { return false }
        flowController = FlowController(navigationController: navigation)
        flowController?.start()
        return true
    }
}

