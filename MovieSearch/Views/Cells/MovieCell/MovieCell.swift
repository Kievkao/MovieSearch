//
//  MovieCell.swift
//  MovieSearch
//
//  Created by Andrii Kravchenko on 21.12.17.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var viewModel: MovieCellViewModelProtocol? {
        didSet {
            nameLabel.text = viewModel?.name
            releaseDateLabel.text = viewModel?.releaseDate
            overviewLabel.text = viewModel?.overview
        }
    }
}
