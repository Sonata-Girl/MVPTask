// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран профиля пользователя
final class ProfileViewController: UIViewController {
    // MARK: Types

    private enum TableSections {
        case profileInfo
        case profileSettings
    }

    // MARK: Constants

    enum Constants {
        static let screenTitle = "Profile"
    }

    // MARK: Visual Components

    private let screenTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.screenTitle
        label.font = .setVerdanaBold(withSize: 28)
        label.textColor = .label
        return label
    }()

    private lazy var profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false // отключение возможности выбора
        //        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
        //        tableView.dataSource = self
        //        tableView.delegate = self

        return tableView
    }()

    // MARK: Public Properties

    var presenter: ProfileViewPresenter?

    // MARK: Private Properties

    private var sections: [TableSections] = [.profileInfo, .profileSettings]

    // MARK: Initializers

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: Public methods

    // MARK: IBAction или @objc (not private)

    // MARK: Private Methods

    private func configureNavigationBar() {
        let buttonBar = UIBarButtonItem(customView: screenTitleLabel)
        navigationItem.leftBarButtonItem = buttonBar
    }

    private func configureView() {}

    private func setupHierarchy() {}

    private func setupConstraints() {
        setupMainImageViewConstraint()
    }

    private func setupMainImageViewConstraint() {}
}
