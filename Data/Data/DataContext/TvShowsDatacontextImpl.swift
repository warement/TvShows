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
    
    func testRequest(
        oneTime: Bool,
        completion: @escaping (Result<String?, DataContextExceptionBean>) -> Void
    ) {
        networkProvider
            .sessionManager.request(TvShowsPathrouter.testGetCase)
            .validateResponseWrapper(fromType: String.self, completion: completion)
    }
}
