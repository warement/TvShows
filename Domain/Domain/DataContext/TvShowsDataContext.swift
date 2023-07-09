//
//  TvShowsDataContext.swift
//  Domain
//
//  Created by Lefteris Altouvas Manolou on 2/7/23.
//

import Foundation

public protocol TvShowsDataContext {
    
    func getPopularTvShows() async -> Result<PagedListResult<PopularTvShows>?, BaseException>
    func getTvShowDetails(id: String) async -> Result<TvShowDetails?, BaseException>
}
