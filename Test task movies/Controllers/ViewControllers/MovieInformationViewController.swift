//
//  MovieInformationViewController.swift
//  Test task movies
//
//  Created by Vova on 17.04.2022.
//

import UIKit

final class MovieInformationViewController: UIViewController {
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var voteAverageLabelOutlet: UILabel!
    @IBOutlet weak var releaseDateLabellOutlet: UILabel!
    @IBOutlet weak var overviewLabelOutlet: UILabel!
    @IBOutlet weak var originalLanguageLabelOutlet: UILabel!
    @IBOutlet weak var adultLabelOutlet: UILabel!
    @IBOutlet weak var originalTitleOutlet: UILabel!
    var movie: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie{
            filling(movie)
            configure(movie)
        }
    }
}

// MARK: - Extension
extension MovieInformationViewController {
    func filling (_ model: Result) {
        originalTitleOutlet.text =  model.originalTitle
        voteAverageLabelOutlet.text = "⭐️\(model.voteAverage ?? 0) (\(model.voteCount ?? 0))"
        releaseDateLabellOutlet.text = "Release \(model.releaseDate ?? "")"
        overviewLabelOutlet.text = model.overview
        originalLanguageLabelOutlet.text = "Original language - \(model.originalLanguage)"
        
        if model.adult ?? true {
            adultLabelOutlet.text = "Movie 18+"
        } else {
            adultLabelOutlet.text = "Movie suitable for children"
        }
    }
    
    func configure(_ model: Result ) {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        DispatchQueue.global().async {
            guard let stringURL = model.posterPath else { return }
            
            guard let url = URL(string: "https://www.themoviedb.org/t/p/w440_and_h660_face/\(stringURL)") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.imageOutlet.image = UIImage(data: imageData)
                self.activityIndicator.stopAnimating()
            }
        }
    }
}

