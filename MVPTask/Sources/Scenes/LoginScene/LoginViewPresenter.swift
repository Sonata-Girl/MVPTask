// LoginViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол вью экрана логина
protocol LoginViewProtocol {}

/// Протокол презентера экрана логина
protocol LoginViewPresenterProtocol {}

/// Презентер экрана логина
final class LoginViewPresenter {
    // MARK: Public Properties

    weak var coordinator: LoginSceneCoordinator?

    // MARK: Private Properties

    private weak var view: LoginViewController?

    // MARK: Initializers

    init(view: LoginViewController?) {
        self.view = view
    }
}
