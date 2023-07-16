//
//  Ext_String.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 16/7/23.
//

import Foundation

extension String {
    var isNotEmpty: Bool {
        get {
            self.isEmpty ? false : true
        }
    }
}
