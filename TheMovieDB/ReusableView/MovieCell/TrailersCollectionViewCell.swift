//
//  TrailersCollectionViewCell.swift
//  TheMovieDB
//
//  Created by Rilwanul Huda on 20/06/21.
//

import UIKit

class TrailersCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subView.backgroundColor = .purple
        layer.cornerRadius = 10
    }

    func setupView(model: TrailerModel?) {
        thumbnailImageView.kf.indicatorType = .activity
        let thumbnail = (model?.thumbnailUrl)
        thumbnailImageView.kf.setImage(with: thumbnail)
    }
}


