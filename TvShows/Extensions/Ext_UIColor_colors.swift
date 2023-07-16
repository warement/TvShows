//
//  Ext_UIColor.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 16/7/23.
//

import UIKit

public extension UIColor {
    static var backgroundDefaultPrimary: UIColor {
        return UIColor(named: "backgroundDefaultPrimary") ?? .systemBackground
    }
    
    static var backgroundGroupedPrimary: UIColor {
        return UIColor(named: "backgroundGroupedPrimary") ?? .secondarySystemBackground
    }
    
    static var backgroundGroupedSecondary: UIColor {
        return UIColor(named: "backgroundGroupedSecondary") ?? .secondarySystemBackground
    }
    
    static var brandPrimary: UIColor {
        return UIColor(named: "brandPrimary") ?? .cyan
    }
    
    static var brandSecondary: UIColor {
        return UIColor(named: "brandSecondary") ?? .systemBlue
    }
    
    static var fillPrimary: UIColor {
        return UIColor(named: "fillPrimary") ?? .systemBackground
    }
    
    static var fillSecondary: UIColor {
        return UIColor(named: "fillSecondary") ?? .secondarySystemBackground
    }
    
    static var seperatorPrimary: UIColor {
        return UIColor(named: "seperatorPrimary") ?? .secondarySystemBackground
    }
    
    static var shadowPrimary: UIColor {
        return UIColor(named: "shadowPrimary") ?? .secondarySystemBackground
    }
    
    static var tintBlue: UIColor {
        return UIColor(named: "tintBlue") ?? .systemBlue
    }
    
    static var tintGreen: UIColor {
        return UIColor(named: "tintGreen") ?? .systemGreen
    }
    
    static var tintPrimary: UIColor {
        return UIColor(named: "tintPrimary") ?? .systemBackground
    }
    
    static var tintRed: UIColor {
        return UIColor(named: "tintRed") ?? .systemRed
    }
    
    static var tintSecondary: UIColor {
        return UIColor(named: "tintSecondary") ?? .secondarySystemBackground
    }
    
    static var tintTertiary: UIColor {
        return UIColor(named: "tintTertiary") ?? .tertiarySystemBackground
    }
    
    static var tintWhite: UIColor {
        return UIColor(named: "tintWhite") ?? .white
    }
    
    static var tintYellow: UIColor {
        return UIColor(named: "tintYellow") ?? .systemYellow
    }
}
