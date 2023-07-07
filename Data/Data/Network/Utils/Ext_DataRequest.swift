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
    

}

//open class DataContext {
//    //keeps track of url request started as background tasks
//    public static var bgTasks: [URL: UIBackgroundTaskIdentifier] = [:]
//    //public static var pollings: [Polling] = []
//    public static let decoder: JSONDecoder = JSONDecoder()
//
//    public init() {}
//
////    public static func addPolling(p: Polling) {
////        pollings.append(p)
////    }
////
////    public static func removePolling(p: Polling) {
////        pollings = pollings.filter { $0 !== p }
////    }
////
////    public static func removeTask(forUrl url: URL?) {
////        guard let url = url, let id = bgTasks[url] else {
////            return
////        }
////        UIApplication.shared.endBackgroundTask(taskID: id)
////        bgTasks[url] = nil
////    }
//
//    public static func decodeData<T: Decodable>(ofType type: T.Type, fromResponse response: AFDataResponse<T>) -> T? {
//        if let data = response.data {
//            do {
//                let data: T = try DataContext.decoder.decode(type, from: data)
//                return data
//            } catch let error {
//                print("Decoding Error", error)
//                return nil
//            }
//        }
//        return nil
//    }
//
////    public static func createSignatureHeader(forRequest request: inout URLRequest) {
////        print("x-alliws-yolo debug.... sign request")
////
////        guard var path = request.url?.path,
////              let host = request.url?.host,
////
////                let method = request.httpMethod else {
////                  return
////              }
////
////        if request.url?.query == nil {
////            let absolutePath = request.url?.absoluteString ?? ""
////            if absolutePath.hasSuffix("/") {
////                path += "/"
////            }
////        }
////
////        let date = Date().toMillis()
////        let algorithm = "hmac-sha256"
////        let keyId = "default"
////        let encrypyionKey = "Don’t tell to zag"
////
////        let accept = request.value(forHTTPHeaderField: "Accept") ?? "application/json"
////        switch request.httpMethod! {
////
////        case HTTPMethod.get.rawValue, HTTPMethod.delete.rawValue:
////            let headers = "(request-target) host date accept expires"
////
////            let signaturePlainText = """
////                (request-target): \(method.lowercased()) \(path)
////                host: \(host)
////                date: \(date)
////                accept: \(accept)
////                expires: \(date + 3600000)
////                """
////
////          //  print("plain \(signaturePlainText)")
////            let signature = Data(signaturePlainText.hmac(by: .SHA256, key: encrypyionKey.bytes)).base64EncodedString()
////          //  print("signature: ", signature)
////
////            request.addValue("\(method) \(path)", forHTTPHeaderField: "request-target")
////            request.addValue("\(host)", forHTTPHeaderField: "HOST")
////            request.addValue("\(date)", forHTTPHeaderField: "Date")
////            request.addValue("\(date + 3600000)", forHTTPHeaderField: "Expires")
////
////            if (request.value(forHTTPHeaderField: "Accept")) == nil {
////                request.addValue(accept, forHTTPHeaderField: "Accept")
////            }
////
////            let signatureHeader = "keyId=\"\(keyId)\",algorithm=\"\(algorithm)\",headers=\"\(headers)\",signature=\"\(signature)\""
////            request.addValue("\(signatureHeader)", forHTTPHeaderField: "Request-signature")
////
////        case HTTPMethod.put.rawValue, HTTPMethod.post.rawValue, HTTPMethod.patch.rawValue:
////            var headers = ""
////            var signaturePlainText = ""
////            let contentType = request.value(forHTTPHeaderField: "Content-Type") ?? "application/json"
////            // it is possible to make a request without a body, e.g. otp enrollment ... add the signature in that case
////            if let body = request.httpBody {
////                let bodyHash = body.sha256().base64EncodedString()
////                let contentLength = body.count
////
////              //  print("Signing: ", contentLength)
////                headers = "(request-target) host date expires accept digest content-length content-type"
////
////                signaturePlainText = """
////                    (request-target): \(method.lowercased()) \(path)
////                    host: \(host)
////                    date: \(date)
////                    expires: \(date + 3600000)
////                    accept: \(accept)
////                    digest: SHA-256=\(bodyHash)
////                    content-length: \(contentLength)
////                    content-type: \(contentType)
////                    """
////
////                request.addValue("SHA-256=\(bodyHash)", forHTTPHeaderField: "Digest")
////                request.addValue("\(contentLength)", forHTTPHeaderField: "Content-Length")
////            } else {
////                headers = "(request-target) host date expires accept content-type"
////                signaturePlainText = """
////                    (request-target): \(method.lowercased()) \(path)
////                    host: \(host)
////                    date: \(date)
////                    expires: \(date + 3600000)
////                    accept: application/json
////                    content-type: \(contentType)
////                    """
////            }
////
////          //  print("plain \(signaturePlainText)")
////
////            let signature = Data(signaturePlainText.hmac(by: .SHA256, key: encrypyionKey.bytes)).base64EncodedString()
////
////        //    print("signature \(signature)")
////
////            request.addValue("\(method) \(path)", forHTTPHeaderField: "request-target")
////            request.addValue("\(host)", forHTTPHeaderField: "Host")
////            request.addValue("\(date)", forHTTPHeaderField: "Date")
////            request.addValue("\(date + 3600000)", forHTTPHeaderField: "Expires")
////            if (request.value(forHTTPHeaderField: "Content-Type")) == nil {
////                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
////            }
////            if (request.value(forHTTPHeaderField: "Accept")) == nil {
////                request.addValue(accept, forHTTPHeaderField: "Accept")
////            }
////
////            let signatureHeader = "keyId=\"\(keyId)\",algorithm=\"\(algorithm)\",headers=\"\(headers)\",signature=\"\(signature)\""
////            request.addValue("\(signatureHeader)", forHTTPHeaderField: "Request-signature")
////        default:
////            return
////        }
////    }
//}
