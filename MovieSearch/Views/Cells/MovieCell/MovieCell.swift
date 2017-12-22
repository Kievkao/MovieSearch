//
//  MovieCell.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import UIKit
import RxSwift

class MovieCell: UITableViewCell {
    private var disposeBag = DisposeBag()
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var viewModel: MovieCellViewModelProtocol? {
        didSet {
            disposeBag = DisposeBag()
            
            nameLabel.text = viewModel?.name
            releaseDateLabel.text = viewModel?.releaseDate
            overviewLabel.text = viewModel?.overview
            
            posterImageView.image = #imageLiteral(resourceName: "placeholder")
            viewModel?.poster.asObservable().filter{ $0 != nil }.subscribe(onNext: { [weak self] image in
                self?.posterImageView.image = image
            }).disposed(by: disposeBag)
            viewModel?.loadImage()
        }
    }
}
