//
//  MoviesListTableViewCell.swift
//  Test task movies
//
//  Created by Vova on 15.04.2022.
//

import UIKit

final class MoviesListTableViewCell: UITableViewCell {
    @IBOutlet weak var originalTitleLabelOutlet: UILabel!
    @IBOutlet weak var titleLabelOutlet: UILabel!
    @IBOutlet weak var voteAverageLabelOutlet: UILabel!
    @IBOutlet weak var releaseDateLabelOutlet: UILabel!
    @IBOutlet weak var posterPathImageOutlet: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
}

// MARK: - Extension
extension MoviesListTableViewCell {
    func configure(_ model: Result ) {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        DispatchQueue.global().async {
            guard let stringURL = model.posterPath else { return }
            
            guard let url = URL(string: "https://www.themoviedb.org/t/p/w440_and_h660_face/\(stringURL)") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.posterPathImageOutlet.image = UIImage(data: imageData)
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func refresh(_ model: Result){
        originalTitleLabelOutlet.text = model.originalTitle
        titleLabelOutlet.text = model.overview
        voteAverageLabelOutlet.text = "⭐️\(model.voteAverage ?? 0)"
        releaseDateLabelOutlet.text = model.releaseDate
    }
}
