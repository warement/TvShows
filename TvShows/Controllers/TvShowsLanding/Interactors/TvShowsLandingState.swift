//
//  TvShowsLandingState.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 2/7/23.
//

import Foundation
import Domain

class TvShowsLandingState: BaseState {
    let isLoading: Bool
    let popularTvShows: [TvShowsDTO]
    let topRatedTvShows: [TvShowsDTO]
    let imageData: Data
    
    init (
        isLoading: Bool = false,
        popularTvShows: [TvShowsDTO] = [TvShowsDTO()],
        topRatedTvShows: [TvShowsDTO] = [TvShowsDTO()],
        imageData: Data = Data()
    ) {
        self.isLoading = isLoading
        self.popularTvShows = popularTvShows
        self.topRatedTvShows = topRatedTvShows
        self.imageData = imageData
    }
    
    func copy(
        isLoading: Bool? = nil,
        popularTvShows: [TvShowsDTO]? = nil,
        topRatedTvShows: [TvShowsDTO]? = nil,
        imageData: Data? = nil
    ) -> TvShowsLandingState {
        return TvShowsLandingState(
            isLoading: isLoading ?? self.isLoading,
            popularTvShows: popularTvShows ?? self.popularTvShows,
            topRatedTvShows: topRatedTvShows ?? self.topRatedTvShows,
            imageData: imageData ?? self.imageData
        )
    }
    
    func baseCopy(isLoading: Bool?) -> Self {
        return self.copy(isLoading: isLoading) as! Self
    }
}
