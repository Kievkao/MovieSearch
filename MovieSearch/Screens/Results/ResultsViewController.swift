//
//  ResultsViewController.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import UIKit
import RxSwift

final class ResultsViewController: UITableViewController {
    let disposeBag = DisposeBag()    
    var viewModel: ResultsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0
        tableView.tableFooterView = UIView()
    }
    
    private func bindViewModel() {
        viewModel.items.asObservable()            
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel.errorSubject
            .bind(to: rx.errorPresentor)
            .disposed(by: disposeBag)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell

        let movie = viewModel.items.value[indexPath.row]
        cell.viewModel = MovieCellViewModel(movie: movie, serviceFactory: viewModel.serviceFactory)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if shouldLoadNextPage(indexPath: indexPath) {            
            viewModel.loadNextPage()
        }
    }
    
    private func shouldLoadNextPage(indexPath: IndexPath) -> Bool {
        return !viewModel.isDataLoading && indexPath.row == (viewModel.items.value.count - 3)
    }
}
