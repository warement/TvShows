//
//  TvShowsLandingEvents.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 2/7/23.
//

import Foundation

enum TvShowsLandingEvents {
    case fetchData
    case getPopularTvShows
    case getTvShowDetails(id: String)
    case getTvShowImage
}
