//
//  TvShowsLandingViewModel.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 2/7/23.
//

import Foundation
import Domain
import Data
import RxSwift
import RxCocoa

class TvShowsLandingViewModel: BaseViewModel {
    
    @Injected(\.tvShowsDataContext)
    private var tvShowsDataContext: TvShowsDataContext
    
    weak var actionHandler: BaseActionHandler?
    
    typealias State = TvShowsLandingState
    typealias Event = TvShowsLandingEvents
    
    let state: BehaviorRelay<State>
    
    var stateObserver: Observable<State> {
        return state.asObservable()
    }
    
    init(actionHandler: BaseActionHandler) {
        self.actionHandler = actionHandler
        state = BehaviorRelay(value: TvShowsLandingState())
        commonInit()
    }
    
    func onTriggeredEvent(event: Event) {
        switch event {
        case .fetchData:
            getPopularTvShows()
        case .getTvShowDetails(let id):
            getTvShowDetails(id: id)
        }
    }
    
    // PRIVATE METHOD IMPLEMENTATION
    private func getPopularTvShows() {
        Task.init {
            let result = await tvShowsDataContext.getPopularTvShows()
            switch result {
            case .success(let popularMovies):
                print(popularMovies ?? "")
            case .failure(let error):
                self.handleErrors(error: error)
            }
        }
    }
    
    private func getTvShowDetails(id: String) {
        Task.init {
            let result = await tvShowsDataContext.getTvShowDetails(id: id)
            switch result {
            case .success(let tvShowDetails):
                print("tvShow details are: \(String(describing: tvShowDetails))")
            case .failure(let error):
                self.handleErrors(error: error)
            }
        }
    }
}
