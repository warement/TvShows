//
//  TvShowDetailsState.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 15/7/23.
//

import Foundation
//
//  TvShowsLandingState.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 2/7/23.
//

import Foundation
import Domain
import RxDataSources

class TvShowDetailsState: BaseState {
    let isLoading: Bool
    let tvShow: TvShowDetails
    
    init (
        isLoading: Bool = false,
        tvShow: TvShowDetails = TvShowDetails()
    ) {
        self.isLoading = isLoading
        self.tvShow = tvShow
    }
    
    func copy(
        isLoading: Bool? = nil,
        tvShow: TvShowDetails? = nil
    ) -> TvShowDetailsState {
        return TvShowDetailsState(
            isLoading: isLoading ?? self.isLoading,
            tvShow: tvShow ?? self.tvShow
        )
    }
    
    func baseCopy(isLoading: Bool?) -> Self {
        return self.copy(isLoading: isLoading) as! Self
    }
}
