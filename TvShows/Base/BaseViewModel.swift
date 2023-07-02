//
//  BaseViewModel.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 2/7/23.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - BaseState
public protocol BaseState {
    var isLoading: Bool { get }
    //    var isOnline: Bool { get }
    
    func baseCopy(
        isLoading: Bool?
    ) -> Self
}

public protocol BaseViewModel: ReactiveCompatible, BaseErrorHandler {
    associatedtype State: BaseState
    associatedtype Event
    
    var state: BehaviorRelay<State> { get }
    var stateObserver: Observable<State> { get }
    
    func commonInit()
    func onTriggeredEvent(event: Event)
}

// MARK: - BaseViewModel
extension BaseViewModel {
    
    public func commonInit() {
        setUpBaseStateObserver()
    }
    
    private func setUpBaseStateObserver() {
        stateObserver
            .observe(on: MainScheduler.instance)
            .map { newState -> Bool in
                return newState.isLoading
            }
            .distinctUntilChanged()
            .subscribe(onNext: { isLoading in
                if isLoading {
                    //AlertHelper.shared.showLoader()
                } else {
                    //AlertHelper.shared.hideLoader()
                }
            }).disposed(by: rx.disposeBag)
    }
}

// MARK: - BaseErrorHandler
public protocol BaseErrorHandler: AnyObject {
    
    @discardableResult
    func handleErrors(error: String) -> Bool
}

// MARK: - BaseErrorHandler Default IMPL
extension BaseErrorHandler {
    
    @discardableResult
    public func handleErrors(
        error: String//DataContextExceptionBean,
        //config: HandleErrorsConfig = HandleErrorsConfig.Builder().build()
    ) -> Bool {
        //        // let genericErrorMessage = config.genericErrorMessage
        //
        //
        //        // MARK: Handle Unauthorized
        //        else if error.errorCode == 401 {
        //
        //            // custom handling
        //            guard config.handleUnauthorize == nil else {
        //                config.handleUnauthorize?()
        //                return true
        //            }
        //
        //            if !PlatformDataContextImpl.shared.authToken.isEmpty {
        //                self.logUserOut(isHard: true)
        //            }
        //
        //            return true
        //        }
        //        // MARK: Handle Unenrolled
        //        else if error.errorCode == 403 {
        //
        //            // custom handling
        //            guard config.handleUnenroll == nil else {
        //                config.handleUnenroll?()
        //                return true
        //            }
        //
        //            if !PlatformDataContextImpl.shared.authToken.isEmpty {
        //                self.logUserOut(isHard: true)
        //            }
        //
        //            return true
        //        }
        //        // MARK: Handle 6 months pass expiration
        //        else if error.errorCode == 202, let errorBody = error.exception {
        //
        //            // custom handling
        //            guard config.handlePassExpiration == nil else {
        //                config.handlePassExpiration?()
        //                return true
        //            }
        //
        //            self.handlePasswordExpiration(exceptions: errorBody)
        //
        //            return true
        //        }
        //        // MARK: default error handling.
        //        else {
        //
        //            // custom handling
        //            guard config.defaultHandling == nil else {
        //                config.defaultHandling?()
        //                return true
        //            }
        //
        //            AlertHelper.shared.showToastOnTop(message: genericErrorMessage, type: .error)
        //
        //            return true
        //        }
        //
        //        return false
        //    }
        return true
        
    }
}

