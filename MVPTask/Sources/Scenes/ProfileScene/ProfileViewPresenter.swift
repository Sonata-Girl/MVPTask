// ProfileViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол вью экрана профиля
protocol ProfileViewProtocol: AnyObject {
    /// Перезагрузка шапки профиля на экране
    func reloadHeaderProfile()
}

/// Протокол презентера экрана профиля
protocol ProfileViewPresenterProtocol: AnyObject {
    /// Пользователь
    var user: User? { get }
    /// Типы ячеек для информации пользователя
    var profileInfoCellTypes: [ProfileInfoCellTypes] { get }
    ///  Показать алерт для изменения имени
    func showChangeNameInputAlert()
    ///  Показать экран отображения бонусов
    func showBonusesScreen()
    ///  Показать вопрос о выходе из профиля
    func showLogOutAlert()
    ///  Показать алерт для соглашений и политики
    func showTermsAlert()
}

/// Презентер экрана профиля
final class ProfileViewPresenter: ProfileViewPresenterProtocol {
    // MARK: Constants

    private enum Constants {
        static let titleChangeNameInput = "Change your name and surname"
        static let placeHolderNameInput = "Name Surname"
        static let titleLogOutAlert = "Are you sure you want to log out?"
        static let defaultButtonLogOutAlert = "Yes"
        static let titleTermsAlert = "Functionality in development"
        static let defaultButtonTermsAlert = "Ok"
    }

    // MARK: Private Methods

    private let storageSource = StorageService()
    private weak var coordinator: ProfileSceneCoordinator?
    private(set) var user: User?
    private(set) var profileInfoCellTypes: [ProfileInfoCellTypes] = [.bonuses, .terms, .logOut]

    // MARK: Private Properties

    private weak var view: ProfileViewProtocol?

    // MARK: Initializers

    init(
        view: ProfileViewProtocol?,
        coordinator: ProfileSceneCoordinator
    ) {
        self.view = view
        self.coordinator = coordinator
        user = storageSource.getUser()
    }

    // MARK: Public Methods

    func showChangeNameInputAlert() {
        let viewController = view as? UIViewController
        viewController?.showInputAlert(
            title: Constants.titleChangeNameInput,
            placeHolder: Constants.placeHolderNameInput
        ) { [weak self] textInput in
            let name = textInput.components(separatedBy: " ").first
            let surname = textInput.components(separatedBy: " ").last
            self?.user?.name = name ?? ""
            self?.user?.surname = surname ?? ""

            self?.view?.reloadHeaderProfile()
        }
    }

    func showLogOutAlert() {
        let viewController = view as? UIViewController
        viewController?.showAlert(
            title: Constants.titleLogOutAlert,
            defaultButtonTitle: Constants.defaultButtonLogOutAlert,
            hasCancel: true
        ) { [weak self] in
            self?.coordinator?.logOut()
        }
    }

    func showTermsAlert() {
        let viewController = view as? UIViewController
        viewController?.showAlert(
            title: Constants.titleTermsAlert,
            hasCancel: false
        )
    }

    func showBonusesScreen() {
        coordinator?.showBonusesScreen()
    }
}
