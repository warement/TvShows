//
//  MainCoordinator.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 1/7/23.
//

import UIKit

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
        
    }
}
