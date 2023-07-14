//
//  TopRatedCollectionReusableViewHeader.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 11/7/23.
//

import UIKit

class CollectionViewReusableViewHeader: UICollectionReusableView {
    
    @IBOutlet weak var titleLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupView(title: String) {
        titleLbl.text = title
    }
}
