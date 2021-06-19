//
//  MovieTableViewCell.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 18/06/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet var moviesCoverImageView: UIImageView!
    @IBOutlet var moviesTitleLabel: UILabel!
    @IBOutlet var moviesReleaseDateLabel: UILabel!
    @IBOutlet var moviesDescriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        moviesCoverImageView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setupView(movie: MoviesModel?) {
        moviesTitleLabel.text = movie?.title
        moviesDescriptionLabel.text = movie?.body
        moviesReleaseDateLabel.text = movie?.date

        moviesCoverImageView.kf.indicatorType = .activity
        let imgUrl = URL(string: movie?.imgUrlString ?? "")
        moviesCoverImageView.kf.setImage(with: imgUrl) 
    }
}
