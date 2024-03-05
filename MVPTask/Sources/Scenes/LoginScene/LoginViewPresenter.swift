// LoginViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Стиль валидации
enum ValideStyle {
    case valid
    case notValide
}

/// Протокол вью экрана логина
protocol LoginViewProtocol: AnyObject {
    /// Настройка изменени цвета текста у емайла
    func changeEmailColor(valideStyle: ValideStyle)
    /// Настройка изменени цвета текста у пароля
    func changePasswordColor(valideStyle: ValideStyle)
}

/// Протокол презентера экрана логина
protocol LoginViewPresenterProtocol: AnyObject {
    /// Валидация для пароля
    func validatePassword(password: String)
    /// Валидация для емайла
    func validateEmail(email: String)
}

/// Презентер экрана логина
final class LoginViewPresenter: LoginViewPresenterProtocol {
    // MARK: Public Properties

    let textPassword = "qwerty12345"
    private weak var coordinator: LoginSceneCoordinator?

    // MARK: Private Properties

    private weak var view: LoginViewProtocol?

    // MARK: Initializers

    init(
        view: LoginViewProtocol?,
        coordinator: LoginSceneCoordinator
    ) {
        self.view = view
        self.coordinator = coordinator
    }

    func validatePassword(password: String) {
        if password == textPassword {
            view?.changePasswordColor(valideStyle: .valid)
            coordinator?.finishFlowHandler?()
        } else {
            view?.changePasswordColor(valideStyle: .notValide)
        }
    }

    func validateEmail(email: String) {
        if email.contains("example@mail.ru") {
            view?.changeEmailColor(valideStyle: .valid)
        } else {
            view?.changeEmailColor(valideStyle: .notValide)
        }
    }
}
