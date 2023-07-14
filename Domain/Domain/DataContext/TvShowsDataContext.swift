//
//  TvShowsDataContext.swift
//  Domain
//
//  Created by Lefteris Altouvas Manolou on 2/7/23.
//

import Foundation

public protocol TvShowsDataContext {
    
    func getPopularTvShows() async -> Result<PagedListResult<TvShows>?, BaseException>
    func getTopRatedTvShows() async -> Result<PagedListResult<TvShows>?, BaseException>
    func getOnTheAirTvShows() async -> Result<PagedListResult<TvShows>?, BaseException>

    func getTvShowDetails(id: String) async -> Result<TvShowDetails?, BaseException>
    func getTvShowImage(size: String, path: String) async -> Result<Data?, BaseException>
}
