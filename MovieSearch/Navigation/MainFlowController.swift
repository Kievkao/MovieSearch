//
//  MainFlowController.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import UIKit

/**
 MainFlowController is used for screens navigation
 
 - func start(): push the initial view controller
 */
final class MainFlowController {
    private let navigation: UINavigationController
    private let storage: Storage
    private let serviceFactory: NetworkServiceFactory
    private let connectivity: Connectivity
    
    init(navigation: UINavigationController, storage: Storage, serviceFactory: NetworkServiceFactory, connectivity: Connectivity) {
        self.navigation = navigation
        self.storage = storage
        self.serviceFactory = serviceFactory
        self.connectivity = connectivity
    }
    
    func start() {
        navigation.setViewControllers([searchViewController()], animated: false)
    }
    
    private func searchViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "Search") as! SearchViewController
        
        let handlers = SearchViewModel.HandlersContainer(searchFinished: { searchQuery, movies in
            self.navigation.pushViewController(self.searchResultViewController(withMovies: movies, searchQuery: searchQuery), animated: true)
        })
        viewController.viewModel = SearchViewModel(storage: storage, serviceFactory: serviceFactory, connectivity: connectivity, handlers: handlers)
        return viewController
    }
    
    private func searchResultViewController(withMovies movies: [Movie], searchQuery: String) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "ResultsViewController") as! ResultsViewController
        viewController.viewModel = ResultsViewModel(searchQuery: searchQuery, initialResults: movies, serviceFactory: serviceFactory, connectivity: connectivity)
        return viewController
    }
    
    private var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}
