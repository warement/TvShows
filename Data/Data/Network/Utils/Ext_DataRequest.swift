//
//  Ext_DataRequest.swift
//  Data
//
//  Created by Lefteris Altouvas Manolou on 2/7/23.
//

import Foundation
import Domain
import Alamofire
extension DataRequest {
    
    public func validateRawResponseWrapper<T: Codable>(
        fromType: T.Type
    ) async -> Result<T?, BaseException> {
        return await validateRawResponseWrapper(
            fromType: T.self,
            mapperType: T.self,
            mapper: { response in
                return response
            }
        )
    }
    
    @discardableResult
    public func validateRawResponseWrapper<T, M>(
        fromType: T.Type,
        mapperType: M.Type,
        mapper: @escaping (T) -> M?
    ) async -> Result<M?, BaseException> where T: (Codable) {
        
        return await withCheckedContinuation { continuation in
            _ = self.validate()
                .responseDecodable(of: T.self) { (response: AFDataResponse<T>) in
                    switch response.result {
                    case .success(let dataResponse):
                        let mappedData = mapper(dataResponse)
                        continuation.resume(returning: Result.success(mappedData))
                    case .failure(let error):
                        print("error is: \(error.localizedDescription)")
                        continuation.resume(
                            returning: Result.failure(
                                BaseException(
                                    errorCode: error.responseCode ?? -1,
                                    throwable: error
                                ))
                        )
                    }
                }.cURLDescription()
        }
    }
    
    @discardableResult
    public func validateImageResponse() async -> Result<Data?, BaseException> {
        return await withCheckedContinuation({ continuation in
            _ = self.validate()
                .responseData(completionHandler: { (response: AFDataResponse<Data>) in
                    if let data = response.data {
                        continuation.resume(returning: Result.success(data))
                    } else {
                        let error = response.error
                        print("error is: \(String(describing: error))")
                        continuation.resume(
                            returning: Result.failure(
                                BaseException(
                                    errorCode: error?.responseCode ?? -1,
                                    throwable: error
                                ))
                        )

                    }
                })
        })
    }
}
