//
//  TopRatedCollectionViewCell.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 9/7/23.
//

import UIKit
import Domain
import Data
import Alamofire
import AlamofireImage

class ReusableCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tvShowImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setup(tvShow: TvShows) {
        guard let imageUrl: URL = (
            URL(string: ConstantKeys.imagesBaseUrl)?.appendingPathComponent("/\(ImageSizes.PosterSizes.w342)\(tvShow.posterPath ?? "")")
        ) else { return }
        tvShowImageView.af.setImage(withURL: imageUrl)
    }
}
