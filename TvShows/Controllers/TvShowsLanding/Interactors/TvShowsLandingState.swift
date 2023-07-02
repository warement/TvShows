//
//  TvShowsLandingState.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 2/7/23.
//

import Foundation

class TvShowsLandingState: BaseState {
    let isLoading: Bool
    
    init (isLoading: Bool = false) {
        self.isLoading = isLoading
    }
    
    func copy(isLoading: Bool? = nil) -> TvShowsLandingState {
        return TvShowsLandingState(isLoading: isLoading ?? self.isLoading)
    }
    
    func baseCopy(isLoading: Bool?) -> Self {
        return self.copy(isLoading: isLoading) as! Self
    }
}
