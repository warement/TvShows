//
//  TvShowsLandingState.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 2/7/23.
//

import Foundation
import Domain
import RxDataSources

enum TvShowsCategories {
    case popular, topRated, onTheAir
}

class TvShowsLandingState: BaseState {
    let isLoading: Bool
    let popularTvShows: [TvShowsDTO]
    let topRatedTvShows: [TvShowsDTO]
    let onTheAirTvShows: [TvShowsDTO]
    
    var tvShowsDisplayable: [SectionModel<String, TvShowsDTO>] {
        var sections: [SectionModel<String, TvShowsDTO>] = []
        if popularTvShows.isNotEmpty {
            sections.append(SectionModel(model: "Popular", items: popularTvShows))
        }
        
        if topRatedTvShows.isNotEmpty {
            sections.append(SectionModel(model: "Top Rated", items: topRatedTvShows))
        }
        
        if onTheAirTvShows.isNotEmpty {
            sections.append(SectionModel(model: "On The Air", items: onTheAirTvShows))
        }
        
        return sections
    }
    
    init (
        isLoading: Bool = false,
        popularTvShows: [TvShowsDTO] = [],
        topRatedTvShows: [TvShowsDTO] = [],
        onTheAirTvShows: [TvShowsDTO] = []
    ) {
        self.isLoading = isLoading
        self.popularTvShows = popularTvShows
        self.topRatedTvShows = topRatedTvShows
        self.onTheAirTvShows = onTheAirTvShows
    }
    
    func copy(
        isLoading: Bool? = nil,
        popularTvShows: [TvShowsDTO]? = nil,
        topRatedTvShows: [TvShowsDTO]? = nil,
        onTheAirTvShows: [TvShowsDTO]? = nil
    ) -> TvShowsLandingState {
        return TvShowsLandingState(
            isLoading: isLoading ?? self.isLoading,
            popularTvShows: popularTvShows ?? self.popularTvShows,
            topRatedTvShows: topRatedTvShows ?? self.topRatedTvShows,
            onTheAirTvShows: onTheAirTvShows ?? self.onTheAirTvShows
        )
    }
    
    func baseCopy(isLoading: Bool?) -> Self {
        return self.copy(isLoading: isLoading) as! Self
    }
}
