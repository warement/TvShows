//
//  MainCoordinator.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 1/7/23.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = TvShowsLandingVC()
        navigationController.pushViewController(vc, animated: false)
    }
}
