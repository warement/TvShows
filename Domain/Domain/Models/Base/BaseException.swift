//
//  BaseException.swift
//  Domain
//
//  Created by Lefteris Altouvas Manolou on 7/7/23.
//

import Foundation

public struct BaseException: Error {
    public let errorCode: Int
    public let throwable: Error?
    public let errorBody: AnyObject? // HERE GOES BACK END EXCEPTION

    public init(
        errorCode: Int = -1,
        errorBody: AnyObject? = nil,
        throwable: Error? = nil
    ) {
        self.errorCode = errorCode
        self.errorBody = errorBody
        self.throwable = throwable
    }
}
