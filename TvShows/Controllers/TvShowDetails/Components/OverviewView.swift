//
//  OverviewView.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 16/7/23.
//

import UIKit

class OverviewView: UIView {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var seperatorLine: UIView!

    let kCONTENT_XIB_NAME = "OverviewView"
            
    // MARK: - Inits
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
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: kCONTENT_XIB_NAME, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    func setupView(title: String, description: String, isSeperatorHidden: Bool = false) {
        titleLbl.attributedText = title.with(.body3(weight: .BOLD, color: .tintTertiary))
        descriptionLbl.attributedText = description.with(.body2(weight: .SEMIBOLD, color: .tintSecondary))
        seperatorLine.backgroundColor = .seperatorPrimary
        seperatorLine.isHidden = isSeperatorHidden
    }

}
