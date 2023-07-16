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
    let imageData: Data
    let overviewData: [OverviewData]
    
    init (
        isLoading: Bool = false,
        tvShow: TvShowDetails = TvShowDetails(),
        imageData: Data = Data(),
        overviewData: [OverviewData] = []
    ) {
        self.isLoading = isLoading
        self.tvShow = tvShow
        self.imageData = imageData
        self.overviewData = overviewData
    }
    
    func copy(
        isLoading: Bool? = nil,
        tvShow: TvShowDetails? = nil,
        imageData: Data? = nil,
        overviewData: [OverviewData]? = nil
    ) -> TvShowDetailsState {
        return TvShowDetailsState(
            isLoading: isLoading ?? self.isLoading,
            tvShow: tvShow ?? self.tvShow,
            imageData: imageData ?? self.imageData,
            overviewData: overviewData ?? self.overviewData
        )
    }
    
    func baseCopy(isLoading: Bool?) -> Self {
        return self.copy(isLoading: isLoading) as! Self
    }
}
