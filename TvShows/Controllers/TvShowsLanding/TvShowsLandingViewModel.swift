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
            fetchData()
        case .getTvShowDetails(let id):
            getTvShowDetails(id: id)
        }
    }
    
    private func fetchData() {
        let dispatchGroup = DispatchGroup()
        state.accept(state.value.copy(isLoading: true))
        getPopularTvShows(dispatchGroup: dispatchGroup)
        getTopRatedTvShows(dispatchGroup: dispatchGroup)
        getOnTheAirTvShows(dispatchGroup: dispatchGroup)
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            self.state.accept(self.state.value.copy(isLoading: false))
        }
    }
    
    // MARK: - Get calls
    private func getPopularTvShows(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        Task.init {
            let result = await self.tvShowsDataContext.getPopularTvShows()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                dispatchGroup.leave()
                switch result {
                case .success(let popularTvShowsPageListResult):
                    self.state.accept(self.state.value.copy(popularTvShows: popularTvShowsPageListResult?.results))
                case .failure(let error):
                    self.handleErrors(error: error)
                }
            }
        }
    }
    
    private func getTopRatedTvShows(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        Task.init {
            let result = await self.tvShowsDataContext.getTopRatedTvShows()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                dispatchGroup.leave()
                switch result {
                case .success(let topRatedTvShowsPageListResult):
                    self.state.accept(self.state.value.copy(topRatedTvShows: topRatedTvShowsPageListResult?.results))
                case .failure(let error):
                    self.handleErrors(error: error)
                }
            }
        }
    }
    
    private func getOnTheAirTvShows(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        Task.init {
            let result = await self.tvShowsDataContext.getOnTheAirTvShows()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                dispatchGroup.leave()
                switch result {
                case .success(let onTheAirTvShowsPageListResult):
                    self.state.accept(self.state.value.copy(onTheAirTvShows: onTheAirTvShowsPageListResult?.results))
                case .failure(let error):
                    self.handleErrors(error: error)
                }
            }
        }
    }
    
    private func getTvShowDetails(id: String) {
        state.accept(state.value.copy(isLoading: true))
        Task.init {
            let result = await self.tvShowsDataContext.getTvShowDetails(id: id)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let tvShowDetails):
                    self.actionHandler?.handleAction(action: GoToTvShowDetails(tvShow: tvShowDetails ?? TvShowDetails()))
                case .failure(let error):
                    self.handleErrors(error: error)
                }
            }
        }
    }    
}
