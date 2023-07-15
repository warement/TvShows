//
//  Ext_Array.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 15/7/23.
//

import Foundation

extension Array {
    
    var isNotEmpty: Bool {
        get {
            self.isEmpty ? false : true
        }
    }
}
