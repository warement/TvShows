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
    
    // MARK: - Inject DataModule AppConfig.
    //    private var appConfig: DataAppConfig {
    //        @Injected(\.dataAppConfig)
    //        var appConfig: DataAppConfig
    //        return appConfig
    //    }
    
    ///# Device Register Endpoints
    case testGetCase
    case testPostCase
    //case getBlockedHistoryConversations(start: Int?, offset: Int?)
    
    
    // MARK: - Method
    var method: HTTPMethod {
        switch self {
        case .testGetCase:
            return .get
        case .testPostCase:
            return .post
            //        case .k:
            //            return .put
            //        case .:
            //            return .patch
            //        case .:
            //            return .delete
        default:
            break
        }
    }
    // MARK: - Path
    var path: String {
        switch self {
            //        case .getRecentConversationsOfMember:
            //            return "/chat/recent/conversations"
            //        case .getChatHistoryByConversationId(let conversationId, _, _, _):
            //            return "/chat/messages/conversation/\(conversationId)"
        case .testGetCase:
            return "test/get"
        case .testPostCase:
            return "test/post"
        }
    }
    
    // MARK: - Encoding
    var encoding: ParameterEncoding {
        switch method {
        case .put, .post, .get:
            switch self {
            case .testGetCase:
                return URLEncoding.queryString
            case .testPostCase:
                return JSONEncoding.default
                //            case .enrollDevice, .enrolmentOTPConfirmation:
                //                return JSONEncodingWithoutEscapingSlashes.default
                //            }
                
            default:
                return URLEncoding.queryString
            }
        }
        
        // MARK: Headers
        var headers: [String: String] {
            var headers = [
                "Content-Type": "application/json",
            ]
            
            switch self {
                // case .updateUsername:
                //   headers["x-alliws-mock-response"] = "400"
            case .testGetCase:
                headers["Content-Type"] = "text/plain"
            default:
                break
            }
            
            return headers
        }
        
        // MARK: - Functions
        public func asURLRequest() throws -> URLRequest {
            //var url = try appConfig.platformApiBaseUrl.asURL()
            switch self {
                //        case .mapsPlaceDetailsTranslation, .mapsGeocodeTranslation:
                //            /// # for map Api calls use Zag Base url
                //            url = try appConfig.appApiBaseUrl.asURL()
                //        case .dashboardAggregation:
                //            url = try appConfig.appApiBaseUrl.asURL()
                //        case .liveDashboardAggregation:
                //            var request = URLRequest(url: URL(string: path)!)
                //            request.httpMethod = method.rawValue
                //            request.allHTTPHeaderFields = headers
                //            var finalRequest = try encoding.encode(request, with: nil)
                //            return finalRequest
            default:
                break
            }
            
            var request = URLRequest(url: url.appendingPathComponent(path))
            request.httpMethod = method.rawValue
            request.allHTTPHeaderFields = headers
            
            var parameters: Parameters?
            
            switch self {
                //        case .getChatHistoryByConversationId(_, let start, let offset, let messageId):
                //            parameters = [
                //                "start": start as Any,
                //                "offset": offset as Any,
                //                "msg_id": messageId as Any
                //            ]
                //            ///# Login Endpoints
                //        case .loginWithCredentials(let credentials),
                //                .quickLoginWithCredentials(let credentials):
                //            let jsonBody = try JSONEncoder().encode(credentials)
                //            request.httpBody = jsonBody
                
            default:
                break
            }
            
            var finalRequest = try encoding.encode(request, with: parameters)
            //DataContext.createSignatureHeader(forRequest: &finalRequest)
            return finalRequest
        }
    }
    
    public struct JSONEncodingWithoutEscapingSlashes: ParameterEncoding {
        
        // MARK: Properties
        
        /// Returns a `JSONEncoding` instance with default writing options.
        public static var `default`: JSONEncodingWithoutEscapingSlashes { return JSONEncodingWithoutEscapingSlashes() }
        
        /// Returns a `JSONEncoding` instance with `.prettyPrinted` writing options.
        public static var prettyPrinted: JSONEncodingWithoutEscapingSlashes { return JSONEncodingWithoutEscapingSlashes(options: .prettyPrinted) }
        
        /// The options for writing the parameters as JSON data.
        public let options: JSONSerialization.WritingOptions
        
        // MARK: Initialization
        
        /// Creates a `JSONEncoding` instance using the specified options.
        ///
        /// - parameter options: The options for writing the parameters as JSON data.
        ///
        /// - returns: The new `JSONEncoding` instance.
        public init(options: JSONSerialization.WritingOptions = []) {
            self.options = options
        }
        
        // MARK: Encoding
        
        /// Creates a URL request by encoding parameters and applying them onto an existing request.
        ///
        /// - parameter urlRequest: The request to have parameters applied.
        /// - parameter parameters: The parameters to apply.
        ///
        /// - throws: An `Error` if the encoding process encounters an error.
        ///
        /// - returns: The encoded request.
        public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
            var urlRequest = try urlRequest.asURLRequest()
            
            guard let parameters = parameters else { return urlRequest }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters, options: options)
                
                let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)?.replacingOccurrences(of: "\\/", with: "/")
                
                if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }
                
                urlRequest.httpBody = string!.data(using: .utf8)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
            
            return urlRequest
        }
        
        /// Creates a URL request by encoding the JSON object and setting the resulting data on the HTTP body.
        ///
        /// - parameter urlRequest: The request to apply the JSON object to.
        /// - parameter jsonObject: The JSON object to apply to the request.
        ///
        /// - throws: An `Error` if the encoding process encounters an error.
        ///
        /// - returns: The encoded request.
        public func encode(_ urlRequest: URLRequestConvertible, withJSONObject jsonObject: Any? = nil) throws -> URLRequest {
            var urlRequest = try urlRequest.asURLRequest()
            
            guard let jsonObject = jsonObject else { return urlRequest }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: jsonObject, options: options)
                
                let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)?.replacingOccurrences(of: "\\/", with: "/")
                
                if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }
                
                urlRequest.httpBody = string!.data(using: .utf8)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
            
            return urlRequest
        }
    }
    
}
