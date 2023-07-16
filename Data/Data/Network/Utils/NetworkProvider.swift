//
//  NetworkProvider.swift
//  Data
//
//  Created by Lefteris Altouvas Manolou on 2/7/23.
//

import Foundation
import Domain
import Alamofire

public protocol NetworkProvider {
    /*
     What mutating get does?
     
     A lazy stored property is a property whose initial value
     is not calculated until the first time it is used.
     
     By default get computed properties asumes that has
     initializes at protocol conformance (nonmutating get).
     So by using `mutating get` we tell swift that object
     will change after its declaration.
     */
    /**
     # sessionManager:
     This var provides an `Alamofire` sessionManager with custom Configurations
     based on app useCase.
     */
    var sessionManager: Session { mutating get }
        
    //func getServerSentEventSession() -> ServerSentEventsProvider
}

public class NetworkProviderImpl: NetworkProvider {
    
    lazy public var sessionManager: Session = {
        //1 Create a sessionManager using NetworkConfigurator (custom class.) .
        var sessMan = NetworkConfigurator(with: 30).manager
        return sessMan
    }()
    
    public init() {}
}
