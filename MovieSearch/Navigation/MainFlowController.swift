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
        
        let handlers = SearchViewModel.HandlersContainer(searchFinished: { movies in
            self.navigation.pushViewController(self.searchResultViewController(), animated: true)
        })
        viewController.viewModel = SearchViewModel(storage: storage, serviceFactory: serviceFactory, handlers: handlers)
        return viewController
    }
    
    private func searchResultViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "ResultsViewController") as! ResultsViewController        
        return viewController
    }
    
    private var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}
