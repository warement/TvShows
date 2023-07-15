//
//  TvShowsDatacontextImpl.swift
//  Data
//
//  Created by Lefteris Altouvas Manolou on 2/7/23.
//

import Foundation
import Domain
import Alamofire

class TvShowsDatacontextImpl: TvShowsDataContext {
    
    private var sessionManager: Session
    
    public init(
        sessionManager: Session
    ) {
        self.sessionManager = sessionManager
    }
    
    func getPopularTvShows() async -> Result<PagedListResult<TvShows>?, BaseException> {
        return await sessionManager.request(TvShowsPathrouter.getPopularTvShows)
            .validateRawResponseWrapper(
                fromType: PagedGenericResponse<[TvShows]>.self,
                mapperType: PagedListResult<TvShows>.self,
                mapper: { response in
                    return GenericPagingMapper<TvShows>().domainToPagingData(response: response)
                }
            )
    }
    
    func getTopRatedTvShows() async -> Result<PagedListResult<TvShows>?, BaseException> {
        return await sessionManager.request(TvShowsPathrouter.getTopRatedTvShows)
            .validateRawResponseWrapper(
                fromType: PagedGenericResponse<[TvShows]>.self,
                mapperType: PagedListResult<TvShows>.self,
                mapper: { response in
                    return GenericPagingMapper<TvShows>().domainToPagingData(response: response)
                }
            )
    }
    
    func getOnTheAirTvShows() async -> Result<PagedListResult<TvShows>?, BaseException> {
        return await sessionManager.request(TvShowsPathrouter.getOnTheAirTvShows)
            .validateRawResponseWrapper(
                fromType: PagedGenericResponse<[TvShows]>.self,
                mapperType: PagedListResult<TvShows>.self,
                mapper: { response in
                    return GenericPagingMapper<TvShows>().domainToPagingData(response: response)
                }
            )
    }
    
    func getTvShowDetails(id: String) async -> Result<TvShowDetails?, BaseException> {
        return await sessionManager.request(TvShowsPathrouter.getTvShowDetails(id: id))
            .validateRawResponseWrapper(fromType: TvShowDetails.self)
    }
    
    func getTvShowImage(size: String, path: String) async -> Result<Data?, BaseException> {
        return await sessionManager.request(TvShowsPathrouter.getImage(size: size, path: path))
            .validateImageResponse()
    }
}
