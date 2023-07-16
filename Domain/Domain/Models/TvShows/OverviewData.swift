//
//  OverviewData.swift
//  Domain
//
//  Created by Lefteris Altouvas Manolou on 16/7/23.
//

import Foundation

public struct OverviewData: Equatable {
    
    public let title: String
    public let description: String
    
    public init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}
