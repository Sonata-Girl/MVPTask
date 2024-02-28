// BonusesViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол вью экрана отображения бонусов профиля
protocol BonusesViewProtocol: AnyObject {}

/// Протокол презентера экрана отображения бонусов профиля
protocol BonusesPresenterProtocol: AnyObject {}

/// Презентер экрана отображения бонусов профиля
final class BonusesViewPresenter: BonusesPresenterProtocol {
    private weak var view: BonusesViewProtocol?
    weak var coordinator: ProfileSceneCoordinator?

    init(view: BonusesViewProtocol? = nil) {
        self.view = view
    }
}
