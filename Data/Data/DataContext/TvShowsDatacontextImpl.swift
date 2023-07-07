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
    
    private var networkProvider: NetworkProvider
    
    public init(
        networkProvider: NetworkProvider
    ) {
        self.networkProvider = networkProvider
    }
    
    func getPopularTvShows() async -> Result<PagedListResult<PopularTvShows>?, BaseException> {
        return await networkProvider
            .sessionManager.request(TvShowsPathrouter.getPopularTvShows)
            .validateRawResponseWrapper(
                fromType: PagedGenericResponse<[PopularTvShows]>.self,
                mapperType: PagedListResult<PopularTvShows>.self,
                mapper: { response in
                    return GenericPagingMapper<PopularTvShows>().domainToPagingData(response: response)
                }
            )
    }
}
