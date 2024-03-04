// BaseCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Главный координатор, от которого наследуются другие координаторы
class BaseCoordinator {
    var childCoordinators: [BaseCoordinator] = []

    func start() {
        fatalError("child должен быть реализован")
    }

    func add(coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }

    func remove(coordinator: BaseCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }

    func setAsRoot​(​_​ controller: UIViewController) {
        let window = UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .last { $0.isKeyWindow }
        window?.rootViewController = controller
    }
}
