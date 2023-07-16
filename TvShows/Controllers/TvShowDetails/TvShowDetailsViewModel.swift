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
        case .getImageData:
            getTvShowImage()
        case .getOverviewData:
            createOverviewData()
        }
    }
    
    private func createOverviewData() {
        let tvShow = state.value.tvShow
        var overviewData: [OverviewData] = []
        if let firstAirDate = tvShow.firstAirDate, firstAirDate.isNotEmpty {
            overviewData.append(OverviewData(title: "AIRS", description: firstAirDate))
        }
        if let episodeRunTime = tvShow.episodeRunTime?.first?.description {
            overviewData.append(OverviewData(title: "RUNTIME", description: episodeRunTime))
        }
        if let languagesData = tvShow.languages?.joined(separator: ","), languagesData.isNotEmpty {
            overviewData.append(OverviewData(title: "LANGUAGES", description: languagesData))
        }
        if let genresData = tvShow.genres?.map({ $0.name ?? "" }).joined(separator: ", "), genresData.isEmpty {
            overviewData.append(OverviewData(title: "GENRES", description: genresData))
        }
        if let overview = tvShow.overview, overview.isNotEmpty {
            overviewData.append(OverviewData(title: "SYNOPSIS", description: overview))
        }
        state.accept(state.value.copy(overviewData: overviewData))
    }
    
    // MARK: - Get Calls
    private func getTvShowImage() {
        Task.init {
            let result = await tvShowsDataContext.getTvShowImage(size: ImageSizes.PosterSizes.w500, path: state.value.tvShow.posterPath ?? "")
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.state.accept(self.state.value.copy(isLoading: false))
                switch result {
                case .success(let data):
                    self.state.accept(self.state.value.copy(imageData: data))
                case .failure(let error):
                    self.handleErrors(error: error)
                }
            }
        }
    }

}
