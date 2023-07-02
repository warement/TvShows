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
    
    @discardableResult
    public func validateResponseWrapper<T>(
        fromType: T.Type,
        completion: @escaping (Domain.Result<T?, DataContextExceptionBean>) -> Void
    ) -> Self where T: (Codable) {
        
        return validateResponseWrapper(
            fromType: T.self,
            mapperType: T.self,
            mapper: { genericResponse in
                return genericResponse.data
            },
            completion: completion
        )
    }

    @discardableResult
    public func validateResponseWrapper<T, M>(
        fromType: T.Type,
        mapperType: M.Type,
        mapper: @escaping (ExtendedGenericResponse<T>) -> M?,
        completion: @escaping (Domain.Result<M?, DataContextExceptionBean>) -> Void
    ) -> Self where T: (Codable) {
        
        return validate()
//            .prettyPrintedJsonResponse()
            .responseDecodable(of: ExtendedGenericResponse<T>.self) { (response: AFDataResponse<ExtendedGenericResponse<T>>) in
                switch response.result {
                case .success(let dataResponse):
                    // Event if the be responds with success we give priority to the exception, if there is an exception
                    if dataResponse.exceptions?.errors?.isEmpty == false {
                        let exceptionBean = self.createDataContextExceptionBean(response: response)
                        print("exception bean is: \(exceptionBean)")
                        completion(Result.Failure(exceptionBean))
                    } else {
                        response.data?.prettyPrint()
                        let mappedData = mapper(dataResponse)
                        completion(Result.Success(mappedData))
                    }
                case .failure(let error):
                    let exceptionBean = self.createDataContextExceptionBean(response: response)
                    print("exception bean is: \(exceptionBean)")
                    print(error.localizedDescription)
                    completion(Result.Failure(exceptionBean))
                }
            }
    }
    
    private func createDataContextExceptionBean<T>(response: AFDataResponse<ExtendedGenericResponse<T>>) -> DataContextExceptionBean {
        return DataContextExceptionBean(
            errorCode: response.response?.statusCode,
            url: response.request?.url?.absoluteString,
            error: response.error,
            exception: DataContext.decodeData(
                ofType: ExtendedGenericResponse<T>.self,
                fromResponse: response
            )?.exceptions,
            feedback: DataContext.decodeData(
                ofType: ExtendedGenericResponse<T>.self,
                fromResponse: response
            )?.feedback
        )
    }
}
