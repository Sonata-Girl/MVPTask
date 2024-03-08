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

    private weak var coordinator: LoginSceneCoordinator?

    // MARK: Private Properties

    private weak var view: LoginViewProtocol?
    private let userProfileService = UserDataCaretaker()
    private var user: User?
    private var login: String = ""

    // MARK: Initializers

    init(
        view: LoginViewProtocol?,
        coordinator: LoginSceneCoordinator
    ) {
        self.view = view
        self.coordinator = coordinator
    }

    func validatePassword(password: String) {
        user = userProfileService.retrieveUserProfileData()
        if let user {
            let comparisonResultPassword = password.compare(
                user.password,
                options: [.caseInsensitive, .diacriticInsensitive]
            )
            let comparisonResultMail = login.compare(
                user.login,
                options: [.caseInsensitive, .diacriticInsensitive]
            )

            if comparisonResultPassword == .orderedSame, comparisonResultMail == .orderedSame {
                view?.changePasswordColor(valideStyle: .valid)
                coordinator?.finishFlowHandler?()
            } else {
                view?.changePasswordColor(valideStyle: .notValide)
            }
        } else {
            if password.isValidPassword() {
                view?.changePasswordColor(valideStyle: .valid)
                userProfileService.save(
                    userProfile: User(
                        name: "UserName",
                        surname: "UserSurname",
                        imageBase64: "",
                        password: password,
                        login: login
                    )
                )
                coordinator?.finishFlowHandler?()
            } else {
                view?.changePasswordColor(valideStyle: .notValide)
            }
        }
    }

    func validateEmail(email: String) {
        if email.isValidEmail() {
            login = email
            view?.changeEmailColor(valideStyle: .valid)
        } else {
            view?.changeEmailColor(valideStyle: .notValide)
        }
    }
}
