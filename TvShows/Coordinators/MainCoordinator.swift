//
//  MainCoordinator.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 1/7/23.
//

import UIKit
import Domain

struct GoToTvShowDetails: Action {
    let tvShow: TvShowDetails
}

class MainCoordinator: Coordinator {
    var parentCoordinator: (any Coordinator)?
    var childCoordinators: [String : any Coordinator] = [:]
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = TvShowsLandingVC(viewModel: TvShowsLandingViewModel(actionHandler: self))
        navigationController.pushViewController(vc, animated: false)
    }
    
    func handleAction(action: Action) {
        switch action {
        case let action as GoToTvShowDetails:
            let viewModel = TvShowDetailsViewModel(actionHandler: self, tvShow: action.tvShow)
            let vc = TvShowDetailsVC(viewModel: viewModel)
            navigationController.pushViewController(vc, animated: true)
            //vc.navigationController?.navigation
        default:
            break
        }
    }
}
