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
    private let apiManager: APIManager
    
    init(navigation: UINavigationController, storage: Storage, apiManager: APIManager) {
        self.navigation = navigation
        self.storage = storage
        self.apiManager = apiManager
    }
    
    func start() {
        navigation.setViewControllers([searchViewController()], animated: false)
    }
    
    private func searchViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "Search") as! SearchViewController
        viewController.viewModel = SearchViewModel(storage: storage, apiManager: apiManager)
        return viewController
    }
    
    private var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}
