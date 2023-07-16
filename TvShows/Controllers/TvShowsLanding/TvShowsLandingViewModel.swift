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
            let result = await tvShowsDataContext.getPopularTvShows()
            dispatchGroup.leave()
            switch result {
            case .success(let popularTvShowsPageListResult):
                state.accept(state.value.copy(popularTvShows: popularTvShowsPageListResult?.results))
            case .failure(let error):
                self.handleErrors(error: error)
            }
        }
    }
    
    private func getTopRatedTvShows(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        Task.init {
            let result = await tvShowsDataContext.getTopRatedTvShows()
            dispatchGroup.leave()
            switch result {
            case .success(let topRatedTvShowsPageListResult):
                state.accept(state.value.copy(topRatedTvShows: topRatedTvShowsPageListResult?.results))
            case .failure(let error):
                self.handleErrors(error: error)
            }
        }
    }
    
    private func getOnTheAirTvShows(dispatchGroup: DispatchGroup) {
        dispatchGroup.enter()
        Task.init {
            let result = await tvShowsDataContext.getOnTheAirTvShows()
            dispatchGroup.leave()
            switch result {
            case .success(let onTheAirTvShowsPageListResult):
                state.accept(state.value.copy(onTheAirTvShows: onTheAirTvShowsPageListResult?.results))
            case .failure(let error):
                self.handleErrors(error: error)
            }
        }
    }
    
    private func getTvShowDetails(id: String) {
        let tvShow: TvShowDetails = TvShowDetails(episodeRunTime: [55], firstAirDate: "2023-06-21", genres: [Genres(id: 18, name: "Drama")], id: 114472, inProduction: true, languages: ["en"], name: "Secret Invasion", numberOfEpisodes: 6, numberOfSeasons: 1, overview: "Nick Fury and Talos discover a faction of shapeshifting Skrulls who have been infiltrating Earth for years", status: "Returning Series", tagline: "Who do you trust?", type: "Miniseries", voteAverage: 7.4, voteCount: 281)
        actionHandler?.handleAction(action: GoToTvShowDetails(tvShow: tvShow))
//        Task.init {
//            let result = await tvShowsDataContext.getTvShowDetails(id: id)
//            switch result {
//            case .success(let tvShowDetails):
//                print("tvShow details are: \(String(describing: tvShowDetails))")
//                actionHandler?.handleAction(action: GoToTvShowDetails())
//            case .failure(let error):
//                self.handleErrors(error: error)
//            }
//        }
    }
    
    private func getTvShowImage(size: String, path: String) async -> Data? {
        let result = await tvShowsDataContext.getTvShowImage(size: size, path: path)
        switch result {
        case .success(let data):
            print(data)
            return data
            //state.accept(state.value.copy(imageData: data))
        case .failure(let error):
            self.handleErrors(error: error)
            return nil
        }
    }
}
