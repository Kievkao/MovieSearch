//
//  MainFlowController.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import UIKit

final class MainFlowController {
    private let navigation: UINavigationController
    private let storage: Storage
    private let serviceFactory: NetworkServiceFactory
    
    init(navigation: UINavigationController, storage: Storage, serviceFactory: NetworkServiceFactory) {
        self.navigation = navigation
        self.storage = storage
        self.serviceFactory = serviceFactory
    }
    
    func start() {
        navigation.setViewControllers([searchViewController()], animated: false)
    }
    
    private func searchViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "Search") as! SearchViewController
        viewController.viewModel = SearchViewModel(storage: storage, serviceFactory: serviceFactory)
        return viewController
    }
    
    private var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}
