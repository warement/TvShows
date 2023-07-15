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
//            getTvShows(tvShowCategory: .popular)
//            getTvShows(tvShowCategory: .topRated)
//            getTvShows(tvShowCategory: .onTheAir)
            getPopularTvShows()
            getTopRatedTvShows()
            getOnTheAirTvShows()
        case .getTvShowDetails(let id):
            getTvShowDetails(id: id)
        }
    }
    
    // PRIVATE METHOD IMPLEMENTATION
//    private func getTvShows(tvShowCategory: TvShowsCategories) {
//        Task.init {
//            var result: Result<PagedListResult<TvShows>?, BaseException>
//            var posterImageSize: String
//            switch tvShowCategory {
//            case .popular:
//                posterImageSize = ImageSizes.PosterSizes.w342
//                result = await tvShowsDataContext.getPopularTvShows()
//            case .topRated:
//                posterImageSize = ImageSizes.PosterSizes.w185
//                result = await tvShowsDataContext.getTopRatedTvShows()
//            case .onTheAir:
//                posterImageSize = ImageSizes.PosterSizes.w185
//                result = await tvShowsDataContext.getOnTheAirTvShows()
//            }
//            switch result {
//            case .success(let tvShowsPageListResult):
//                let tvShows = tvShowsPageListResult?.results ?? []
//                var tvShowsData: [TvShowsDTO] = []
//                for tvShow in tvShows {
//                    let imageData = await getTvShowImage(size: ImageSizes.PosterSizes.w342, path: tvShow.posterPath ?? "")
//                    tvShowsData.append(TvShowsDTO(tvShow: tvShow, posterImage: imageData))
//                }
//                switch tvShowCategory {
//                case .popular:
//                    state.accept(state.value.copy(popularTvShows: tvShowsData))
//                case .topRated:
//                    state.accept(state.value.copy(topRatedTvShows: tvShowsData))
//                case .onTheAir:
//                    state.accept(state.value.copy(onTheAirTvShows: tvShowsData))
//                }
//
//            case .failure(let error):
//                self.handleErrors(error: error)
//            }
//        }
//    }
    
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
                print("....popularMovies error is: \(error)")
                self.handleErrors(error: error)
            }
        }
    }
    
    private func getTopRatedTvShows() {
        Task.init {
            let result = await tvShowsDataContext.getTopRatedTvShows()
            switch result {
            case .success(let topRatedTvShowsPageListResult):
                let topRatedTvShows = topRatedTvShowsPageListResult?.results ?? []
                var topRatedTvShowsData: [TvShowsDTO] = []
                for tvShow in topRatedTvShows {
                    let imageData = await getTvShowImage(size: ImageSizes.PosterSizes.w185, path: tvShow.posterPath ?? "")
                    topRatedTvShowsData.append(TvShowsDTO(tvShow: tvShow, posterImage: imageData))
                }
                state.accept(state.value.copy(topRatedTvShows: topRatedTvShowsData))
            case .failure(let error):
                print("....toprated error is: \(error)")

                self.handleErrors(error: error)
            }
        }
    }
    
    private func getOnTheAirTvShows() {
        Task.init {
            let result = await tvShowsDataContext.getOnTheAirTvShows()
            switch result {
            case .success(let onTheAirTvShowsPageListResult):
                let onTheAirTvShows = onTheAirTvShowsPageListResult?.results ?? []
                var onTheAirTvShowsData: [TvShowsDTO] = []
                for tvShow in onTheAirTvShows {
                    let imageData = await getTvShowImage(size: ImageSizes.PosterSizes.w185, path: tvShow.posterPath ?? "")
                                        onTheAirTvShowsData.append(TvShowsDTO(tvShow: tvShow, posterImage: imageData))
                }
                state.accept(state.value.copy(onTheAirTvShows: onTheAirTvShowsData))
            case .failure(let error):
                print("....ontheari error is: \(error)")

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
