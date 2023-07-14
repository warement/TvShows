//
//  GenreBadge.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 9/7/23.
//

import UIKit
import Domain

class GenreBadge: UIView {
    
    @IBOutlet weak var genreTitleLbl: UILabel!
    
    let kCONTENT_XIB_NAME = "GenreBadge"
    private var contentView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
        [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
        backgroundColor = .clear
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: kCONTENT_XIB_NAME, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }
    
    func setupView(tvShowGenre: String) {
        contentView?.layer.cornerRadius = (contentView?.frame.height ?? 16) / 2
        contentView?.backgroundColor = UIColor(hexString: "#DBE3FF")
        genreTitleLbl.text = tvShowGenre
    }
}
