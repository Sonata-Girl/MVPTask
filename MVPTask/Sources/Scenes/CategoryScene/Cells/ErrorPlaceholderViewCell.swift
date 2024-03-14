// ErrorPlaceholderViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Класс отвечающий за отображение если данные загрузились
final class ErrorPlaceholderViewCell: UITableViewCell {
    // MARK: Constant

    enum Constants {
        static let failedLoadText = "Failed to load data"
        static let lightningImage = "lightningIcon"
        static let reloadImageName = "reloadIcon"
        static let reloadText = "Reload"
    }

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Visual Components

    private let lightningImageView = UIImageView()
    private let failedLabel = UILabel()
    private let reloadButton = UIButton()
    private var heightCellConstraint: NSLayoutConstraint?

    // MARK: Public Properties

    var reloadButtonHandler: VoidHandler?

    // MARK: Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupConstraints()
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupConstraints()
        setupUI()
    }

    // MARK: Public Methods

    func setupLessSize() {
        heightCellConstraint?.constant -= 200
    }

    // MARK: Private Methods

    private func setupHierarchy() {
        contentView.addSubview(lightningImageView)
        contentView.addSubview(failedLabel)
        contentView.addSubview(reloadButton)
    }

    private func setupConstraints() {
        heightCellConstraint = contentView.heightAnchor.constraint(
            equalToConstant: UIScreen.main.bounds.height - 120
        )
        heightCellConstraint?.isActive = true
        addLightningImageViewConstraints()
        addImageViewConstraints()
        addReloadButtonConstraints()
    }

    private func addLightningImageViewConstraints() {
        failedLabel.translatesAutoresizingMaskIntoConstraints = false
        failedLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        failedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        failedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        failedLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }

    private func addImageViewConstraints() {
        lightningImageView.translatesAutoresizingMaskIntoConstraints = false
        lightningImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        lightningImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        lightningImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        lightningImageView.bottomAnchor.constraint(
            equalTo: failedLabel.topAnchor,
            constant: -17
        ).isActive = true
    }

    private func addReloadButtonConstraints() {
        reloadButton.translatesAutoresizingMaskIntoConstraints = false
        reloadButton.topAnchor.constraint(equalTo: failedLabel.bottomAnchor, constant: 25).isActive = true
        reloadButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        reloadButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        reloadButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    private func setupUI() {
        failedLabel.font = .addVerdana(withSize: 14)
        failedLabel.textColor = .systemGray4
        failedLabel.text = Constants.failedLoadText
        failedLabel.textAlignment = .center

        lightningImageView.image = UIImage(named: Constants.lightningImage)
        lightningImageView.contentMode = .center
        lightningImageView.backgroundColor = .systemGray6
        lightningImageView.layer.cornerRadius = 12

        reloadButton.setImage(UIImage(named: Constants.reloadImageName), for: .normal)
        reloadButton.imageView?.contentMode = .center
        reloadButton.setTitle(Constants.reloadText, for: .normal)
        reloadButton.tintColor = .systemGray4
        reloadButton.titleLabel?.font = .addVerdana(withSize: 14)
        reloadButton.setTitleColor(.systemGray4, for: .normal)
        reloadButton.backgroundColor = .systemGray6
        reloadButton.layer.cornerRadius = 12
        reloadButton.addTarget(self, action: #selector(reloadButtonPressed), for: .touchUpInside)
    }

    @objc private func reloadButtonPressed() {
        reloadButtonHandler?()
    }
}
