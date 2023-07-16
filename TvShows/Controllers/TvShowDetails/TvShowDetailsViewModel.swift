//
//  TvShowDetailsViewModel.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 15/7/23.
//

import Foundation
import Domain
import Data
import RxSwift
import RxCocoa

class TvShowDetailsViewModel: BaseViewModel {
    
    @Injected(\.tvShowsDataContext)
    private var tvShowsDataContext: TvShowsDataContext
    
    weak var actionHandler: BaseActionHandler?
    
    typealias State = TvShowDetailsState
    typealias Event = TvShowDetailsEvents
    
    let state: BehaviorRelay<State>
    
    var stateObserver: Observable<State> {
        return state.asObservable()
    }
    
    init(actionHandler: BaseActionHandler, tvShow: TvShowDetails) {
        self.actionHandler = actionHandler
        state = BehaviorRelay(value: TvShowDetailsState())
        state.accept(state.value.copy(tvShow: tvShow))
        commonInit()
    }
    
    func onTriggeredEvent(event: Event) {
        switch event {
        default:
            break
        }
    }
    
    // MARK: - Get calls
    
}
