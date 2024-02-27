// BonusesViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol BonusesViewProtocol: AnyObject {}

protocol BonusesPresenterProtocol: AnyObject {}

final class BonusesViewPresenter: BonusesPresenterProtocol {
    private weak var view: BonusesViewProtocol?
    weak var coordinator: ProfileSceneCoordinator?

    init(view: BonusesViewProtocol? = nil) {
        self.view = view
    }
}
