//
//  CoordinatorKeyImpl.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 2/7/23.
//

import Foundation

public enum CoordinatorKeyImpl: String, CoordinatorKey {
    case mainCoordinator
    
    public var value: String {
        return self.rawValue
    }
}
