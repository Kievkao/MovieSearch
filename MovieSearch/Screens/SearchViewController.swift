//
//  SearchViewController.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import UIKit

final class SearchViewController: UITableViewController {
    var viewModel: SearchViewModelProtocol!
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.dimsBackgroundDuringPresentation = false
        return controller
    }()
    
    private var isSearchActive: Bool {
        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }
    
    private var items: [String] {
        guard isSearchActive, let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            return viewModel.items
        }
        return viewModel.items.filter { $0.lowercased().contains(searchText.lowercased()) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
    }
    
    private func setupSearchController() {
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    //MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionCell", for: indexPath) as! SuggestionCell
        cell.nameLabel.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        tableView.reloadData()
    }
}
