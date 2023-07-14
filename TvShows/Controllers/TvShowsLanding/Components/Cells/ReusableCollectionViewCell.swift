//
//  TopRatedCollectionViewCell.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 9/7/23.
//

import UIKit
import Domain

class ReusableCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tvShowImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setup(tvShow: TvShowsDTO) {
        if let posterImage = tvShow.posterImage {
            tvShowImageView.image = UIImage(data: posterImage)
        }
    }

}
