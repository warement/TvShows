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
    case getTopRatedTvShows
    case getOnTheAirTvShows
    case getTvShowDetails(id: String)
    case getImage(size: String, path: String)
    
    // MARK: - Method
    var method: HTTPMethod {
        switch self {
        case .getPopularTvShows,
                .getTopRatedTvShows,
                .getOnTheAirTvShows
                .getTvShowDetails,
                .getImage:
            return .get
        }
    }
    // MARK: - Path
    var path: String {
        switch self {
        case .getPopularTvShows:
            return "/tv/popular"
        case .getTopRatedTvShows:
            return "/tv/top_rated"
        case .getOnTheAirTvShows:
            return "/tv/on_the_air"
        case .getTvShowDetails(let id):
            return "/tv/\(id)"
        case .getImage(let size, let path):
            return "/\(size)\(path)"
        }
    }
    
    // MARK: - Encoding
    var encoding: ParameterEncoding {
        switch method {
        case .put, .post, .get:
            switch self {
            case .getPopularTvShows,
                    .getTopRatedTvShows,
                    .getOnTheAirTvShows,
                    .getTvShowDetails,
                    .getImage:
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
            "Authorization": "Bearer \(ConstantKeys.accessToken)",
            "language": ConstantKeys.locale
        ]
        
        return headers
    }
    
    // MARK: - Functions
    public func asURLRequest() throws -> URLRequest {
        var url: URL
        switch self {
        case .getImage:
            url = try ConstantKeys.imagesBaseUrl.asURL()
        default:
            url = try ConstantKeys.baseURL.asURL()
        }
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        var parameters: Parameters?
        
        switch self {
        case .getPopularTvShows:
            parameters = [
                "page": 1,
                "sort_by":"created_at.asc"
            ]
        default:
            break
            
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
