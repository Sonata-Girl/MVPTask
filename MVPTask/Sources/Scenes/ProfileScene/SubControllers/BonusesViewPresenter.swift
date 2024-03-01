// BonusesViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол вью экрана отображения бонусов профиля
protocol BonusesViewProtocol: AnyObject {}

/// Протокол презентера экрана отображения бонусов профиля
protocol BonusesPresenterProtocol: AnyObject {}

/// Презентер экрана отображения бонусов профиля
final class BonusesViewPresenter: BonusesPresenterProtocol {
    private weak var view: BonusesViewProtocol?
    private weak var coordinator: ProfileSceneCoordinator?

    init(
        view: BonusesViewProtocol,
        coordinator: ProfileSceneCoordinator
    ) {
        self.view = view
        self.coordinator = coordinator
    }
}
