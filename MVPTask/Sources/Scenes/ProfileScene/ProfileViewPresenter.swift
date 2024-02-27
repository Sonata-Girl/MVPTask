// ProfileViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол вью экрана профиля
protocol ProfileViewProtocol {}

/// Протокол презентера экрана профиля
protocol ProfileViewPresenterProtocol {}

/// Презентер экрана профиля
final class ProfileViewPresenter {
    // MARK: Public Properties

    weak var coordinator: ProfileSceneCoordinator?

    // MARK: Private Properties

    private weak var view: ProfileViewController?

    // MARK: Initializers

    init(view: ProfileViewController?) {
        self.view = view
    }
}
