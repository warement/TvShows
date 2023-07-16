//
//  Ext_UIView.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 16/7/23.
//

import UIKit

extension UIView {
    
    public func addExclusiveConstraints(
        superview: UIView,
        top: (anchor: NSLayoutYAxisAnchor, constant: CGFloat)? = nil,
        bottom: (anchor: NSLayoutYAxisAnchor, constant: CGFloat)? = nil,
        left: (anchor: NSLayoutXAxisAnchor, constant: CGFloat)? = nil,
        right: (anchor: NSLayoutXAxisAnchor, constant: CGFloat)? = nil,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        centerX: NSLayoutXAxisAnchor? = nil,
        centerY: NSLayoutYAxisAnchor? = nil
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)
        if let top = top {
            self.topAnchor.constraint(equalTo: top.anchor, constant: top.constant).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom.anchor, constant: -bottom.constant).isActive = true
        }
        if let left = left {
            self.leadingAnchor.constraint(equalTo: left.anchor, constant: left.constant).isActive = true
        }
        if let right = right {
            self.trailingAnchor.constraint(equalTo: right.anchor, constant: -right.constant).isActive = true
        }
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
}
