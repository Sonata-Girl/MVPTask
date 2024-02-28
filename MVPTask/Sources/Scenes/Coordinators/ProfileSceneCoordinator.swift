// ProfileSceneCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор экрана профиля в таббаре
final class ProfileSceneCoordinator: BaseCoordinator {
    // MARK: Public Properties

    var navigationController: UINavigationController?
    var finishFlowHandler: (() -> ())?

    // MARK: Public Methods

    func setRootViewController(view: UIViewController) {
        navigationController = UINavigationController(
            rootViewController: view
        )
    }

    func showBonusesScreen() {
        guard let currentView = navigationController?.viewControllers.last else { return }
        let bonusesViewController = AppBuilder().makeBonusesModule(coordinator: self)
        bonusesViewController.modalPresentationStyle = .formSheet
        if let sheet = bonusesViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        currentView.present(bonusesViewController, animated: true)
    }

    func logOut() {
        finishFlowHandler?()
    }
}
