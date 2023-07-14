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
        case .getTvShowImage:
            break
            //getTvShowImage(size: "w500", path: "/uh2NbTkUheENmBlUs7Kwb5EaAXQ.jpg")
        case .getPopularTvShows:
            getPopularTvShows()
        }
    }
    
    // PRIVATE METHOD IMPLEMENTATION
    private func getPopularTvShows() {
        Task.init {
            let result = await tvShowsDataContext.getPopularTvShows()
            switch result {
            case .success(let popularTvShowsPageListResult):
                let popularTvShows = popularTvShowsPageListResult?.results ?? []
                var popularTvShowsData: [TvShowsDTO] = []
                for tvShow in popularTvShows {
                    let imageData = await getTvShowImage(size: ImageSizes.PosterSizes.w342, path: tvShow.posterPath ?? "")
                    popularTvShowsData.append(TvShowsDTO(tvShow: tvShow, posterImage: imageData))
                }
                state.accept(state.value.copy(popularTvShows: popularTvShowsData))
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
