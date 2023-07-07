//
//  TvShowsPathrouter.swift
//  Data
//
//  Created by Lefteris Altouvas Manolou on 2/7/23.
//

import Foundation
import Alamofire
import Domain

public enum TvShowsPathrouter: URLRequestConvertible {
    
    ///# Device Register Endpoints
    case getPopularTvShows
    //case getBlockedHistoryConversations(start: Int?, offset: Int?)
    
    
    // MARK: - Method
    var method: HTTPMethod {
        switch self {
        case .getPopularTvShows:
            return .get
        }
    }
    // MARK: - Path
    var path: String {
        switch self {
        case .getPopularTvShows:
            return "/tv/popular"
        }
    }
    
    // MARK: - Encoding
    var encoding: ParameterEncoding {
        switch method {
        case .put, .post, .get:
            switch self {
            case .getPopularTvShows:
                return URLEncoding.queryString
            }
        default:
            return URLEncoding.queryString
        }
    }
    
    // MARK: Headers
    var headers: [String: String] {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(ConstantKeys.accessToken)"
        ]
        
        return headers
    }
    
    // MARK: - Functions
    public func asURLRequest() throws -> URLRequest {
        let url = try ConstantKeys.baseURL.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        var parameters: Parameters?
        
        switch self {
        case .getPopularTvShows:
            parameters = [
                "page": 1,
                "language": ConstantKeys.locale,
                "sort_by":"created_at.asc"
            ]
            
            //            ///# Login Endpoints
            //        case .loginWithCredentials(let credentials),
            //                .quickLoginWithCredentials(let credentials):
            //            let jsonBody = try JSONEncoder().encode(credentials)
            //            request.httpBody = jsonBody
            
        }
        
        let finalRequest = try encoding.encode(request, with: parameters)
        return finalRequest
    }
}
