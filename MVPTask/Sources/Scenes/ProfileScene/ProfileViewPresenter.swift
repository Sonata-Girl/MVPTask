// ProfileViewPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол вью экрана профиля
protocol ProfileViewProtocol {}

/// Протокол презентера экрана профиля
protocol ProfileViewPresenterProtocol {
    var user: User? { get }
}

/// Презентер экрана профиля
final class ProfileViewPresenter: ProfileViewPresenterProtocol {
    // MARK: Public Properties

    weak var coordinator: ProfileSceneCoordinator?
    private(set) var user: User?

    // MARK: Private Properties

    private weak var view: ProfileViewController?

    // MARK: Initializers

    init(view: ProfileViewController?) {
        self.view = view
        user = User(name: "Name", surname: "Surname", imageName: "userAvatar")
    }
}
