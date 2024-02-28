// LoginViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол вью экрана логина
protocol LoginViewProtocol: AnyObject {}

/// Протокол презентера экрана логина
protocol LoginViewPresenterProtocol: AnyObject {}

/// Презентер экрана логина
final class LoginViewPresenter {
    // MARK: Public Properties

    weak var coordinator: LoginSceneCoordinator?

    // MARK: Private Properties

    private weak var view: LoginViewProtocol?

    // MARK: Initializers

    init(view: LoginViewProtocol?) {
        self.view = view
    }
}
