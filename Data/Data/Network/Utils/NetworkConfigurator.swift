//
//  NetworkConfigurator.swift
//  Data
//
//  Created by Lefteris Altouvas Manolou on 2/7/23.
//

import Foundation
import Alamofire

open class NetworkConfigurator {
    open var manager: Session
    public var configuration = URLSessionConfiguration.default
    
    public init(with timeoutInterval: TimeInterval = 30) {
        configuration.timeoutIntervalForRequest = timeoutInterval
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        manager = Session(
            configuration: configuration
        )
    }
    
}
