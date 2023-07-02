//
//  Coordinator.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 1/7/23.
//

import UIKit

protocol Coordinator: AnyObject, ObservableObject, BaseActionHandler {
    var parentCoordinator: (any Coordinator)? { get set }
    var childCoordinators: [String: any Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    // MARK: - Funcs
    func start()
    func stop(completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
    func addChild(coordinator: any Coordinator, with key: CoordinatorKey)
    func removeChild(coordinator: any Coordinator)
    func removeChild(key: CoordinatorKey)
}

public protocol CoordinatorKey {
    var value: String { get }
}

// MARK: Default Implementations.
extension Coordinator {
    
    public func addChild(
        coordinator: any Coordinator,
        with key: CoordinatorKey
    ) {
        childCoordinators[key.value] = coordinator
    }
    
    public func removeChild(coordinator: any Coordinator) {
        childCoordinators = childCoordinators.filter {
            $0.value !== coordinator
        }
    }
    
    public func removeChild(key: CoordinatorKey) {
        if let coord = childCoordinators[key.value] {
            removeChild(coordinator: coord)
            print("Coordinator with key: \(key) removed")
        }
    }
    
    public func getCoordingator(_ key: CoordinatorKey) -> (any Coordinator)? {
        return childCoordinators[key.value]
    }
    
    public func stop(completion: (() -> Void)? = nil) {
        self.parentCoordinator?.removeChild(coordinator: self)
        completion?()
    }
    
    public func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.dismiss(animated: animated) { [weak self] in
            guard let self = self else { return }
            self.stop(completion: completion)
        }
    }
}
