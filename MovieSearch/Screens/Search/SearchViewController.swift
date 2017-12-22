//
//  SearchViewController.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import UIKit
import RxSwift
import RxCocoa

/**
 SearchViewController displays a search field and list of saved successed latest results
 */
final class SearchViewController: UITableViewController {
    let disposeBag = DisposeBag()
    var viewModel: SearchViewModelProtocol!
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.dimsBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Enter movie name".localized()
        return controller
    }()
    
    fileprivate lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        indicator.center = view.center
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private var isSearchActive: Bool {
        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }
    
    private var items: [Search] {
        guard isSearchActive, let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            return viewModel.items.value
        }
        return viewModel.items.value.filter { $0.query.lowercased().contains(searchText.lowercased()) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50.0
        tableView.tableHeaderView = searchController.searchBar
        tableView.tableFooterView = UIView()
        
        definesPresentationContext = true
        searchController.searchBar.delegate = self

        view.addSubview(activityIndicator)
    }
    
    private func bindViewModel() {
        viewModel.items.asObservable()
            .skip(1)
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel.errorSubject
            .bind(to: rx.errorPresentor)
            .disposed(by: disposeBag)
        
        viewModel.progressSubject
            .bind(to: rx.progress)
            .disposed(by: disposeBag)
    }
    
    //MARK: UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionCell", for: indexPath) as! SuggestionCell
        cell.nameLabel.text = items[indexPath.row].query
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.search(items[indexPath.row].query)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        tableView.reloadData()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        viewModel.retrieveHistory()
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.hideHistory()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        viewModel.search(text)
    }
}

extension Reactive where Base: SearchViewController {
    var progress: Binder<Bool> {
        return Binder(self.base) { controller, inProgress in
            if inProgress {
                controller.activityIndicator.startAnimating()
            } else {
                controller.activityIndicator.stopAnimating()
            }
        }
    }
}
