//
//  PagedListResult.swift
//  Domain
//
//  Created by Lefteris Altouvas Manolou on 7/7/23.
//

import Foundation

public struct PagedListResult<T> {
    public let results: [T]
    public let next: Int?
    public let previous: Int?
    public let current: Int?
    public let total: Int?
    
    public init(results: [T] = [],
         next: Int? = nil,
         previous: Int? = nil,
         current: Int? = nil,
         total: Int? = nil
    ) {
        self.results = results
        self.next = next
        self.previous = previous
        self.current = current
        self.total = total
    }
}
