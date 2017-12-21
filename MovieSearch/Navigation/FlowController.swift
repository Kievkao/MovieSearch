//
//  FlowController.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import UIKit

final class FlowController {
    private let navigation: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigation = navigationController
    }
    
    func start() {
        navigation.setViewControllers([searchViewController()], animated: false)
    }
    
    private func searchViewController() -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "Search") as! SearchViewController
        viewController.viewModel = SearchViewModel()
        return viewController
    }
    
    private var storyboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}
