//
//  Coordinator.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 1/7/23.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
