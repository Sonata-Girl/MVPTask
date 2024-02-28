// BonusesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран показа бонусов пользователя
final class BonusesViewController: UIViewController {
    // MARK: Constants

    enum Constants {
        static let screenTitle = "Your bonuses"
        static let countBonusesTitle = "100"
        static let bonusImageName = "profileBonusesIcon"
        static let starImageName = "profileBonusesStarIcon"
        static let closeButtonImage = "closeButton"
    }

    // MARK: Visual Components

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: Constants.closeButtonImage), for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()

    private let screenTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.screenTitle
        label.font = .setVerdanaBold(withSize: 20)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()

    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: Constants.bonusImageName)
        return imageView
    }()

    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: Constants.starImageName)
        return imageView
    }()

    private let bonusesCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdanaBold(withSize: 30)
        label.text = Constants.countBonusesTitle
        label.textColor = .gray
        return label
    }()

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: Public Properties

    var presenter: BonusesPresenterProtocol?

    // MARK: Public Method

    func setupView(bonusesCount: Int) {
        bonusesCountLabel.text = "\(bonusesCount)"
    }

    // MARK: Private Methods

    private func configureView() {
        view.backgroundColor = .white
    }

    private func setupHierarchy() {
        [
            closeButton,
            screenTitleLabel,
            mainImageView,
            starImageView,
            bonusesCountLabel
        ].forEach { view.addSubview($0) }
    }

    private func setupConstraints() {
        setupCloseButtonConstraint()
        setupScreenTitleLabelConstraint()
        setupMainImageViewConstraint()
        setupStarImageViewConstraint()
        setupBonusesCountLabelConstraint()
    }

    private func setupCloseButtonConstraint() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),
            closeButton.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            ),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
        ])
    }

    private func setupScreenTitleLabelConstraint() {
        NSLayoutConstraint.activate([
            screenTitleLabel.topAnchor.constraint(
                equalTo: closeButton.bottomAnchor,
                constant: 20
            ),
            screenTitleLabel.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            screenTitleLabel.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            ),
            screenTitleLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    private func setupMainImageViewConstraint() {
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: screenTitleLabel.bottomAnchor, constant: 13),
            mainImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 120),
            mainImageView.widthAnchor.constraint(equalTo: mainImageView.heightAnchor),
        ])
    }

    private func setupStarImageViewConstraint() {
        NSLayoutConstraint.activate([
            starImageView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 20),
            starImageView.leadingAnchor.constraint(
                equalTo: mainImageView.leadingAnchor,
                constant: 10
            ),
            starImageView.heightAnchor.constraint(equalToConstant: 35),
            starImageView.widthAnchor.constraint(equalTo: starImageView.heightAnchor),
        ])
    }

    private func setupBonusesCountLabelConstraint() {
        NSLayoutConstraint.activate([
            bonusesCountLabel.topAnchor.constraint(equalTo: starImageView.topAnchor),
            bonusesCountLabel.leadingAnchor.constraint(
                equalTo: starImageView.trailingAnchor,
                constant: 10
            ),
            bonusesCountLabel.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            ),
            bonusesCountLabel.heightAnchor.constraint(equalToConstant: 35),
        ])
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - BonusesViewProtocol

/// BonusesViewController + BonusesViewProtocol
extension BonusesViewController: BonusesViewProtocol {}
