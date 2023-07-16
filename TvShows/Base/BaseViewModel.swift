//
//  BaseViewModel.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 2/7/23.
//

import Foundation
import RxSwift
import RxCocoa
import Domain

// MARK: - BaseState
public protocol BaseState {
    var isLoading: Bool { get }
    
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
            .map { $0.isLoading }
            .distinctUntilChanged()
            .subscribe(onNext: { isLoading in
                if isLoading {
                    self.actionHandler?.handleBaseAction(action: ShowLoaderAction())
                } else {
                    self.actionHandler?.handleBaseAction(action: HideLoaderAction())
                }
            }).disposed(by: rx.disposeBag)
    }
}

// MARK: - BaseErrorHandler
public protocol BaseErrorHandler: AnyObject, BaseActionDispatcher {
    
    @discardableResult
    func handleErrors(error: BaseException) -> Bool
}

// MARK: - BaseErrorHandler Default IMPL
extension BaseErrorHandler {
    
    @discardableResult
    public func handleErrors(
        error: BaseException
    ) -> Bool {
        print(error.localizedDescription)
        return true
    }
}

