//
//  DataContextExceptionBean.swift
//  Domain
//
//  Created by Lefteris Altouvas Manolou on 2/7/23.
//

import Foundation

public struct DataContextExceptionBean: Error {
    public let errorCode: Int?
    public let url: String?
    public let error: Error?
    public let exception: ExceptionBean?
    public let feedback: String?
    
    public init(errorCode: Int? = nil, url: String? = nil, error: Error? = nil, exception: ExceptionBean? = nil, feedback: String? = nil) {
        self.errorCode = errorCode
        self.url = url
        self.error = error
        self.feedback = feedback
        self.exception = exception
    }
}
