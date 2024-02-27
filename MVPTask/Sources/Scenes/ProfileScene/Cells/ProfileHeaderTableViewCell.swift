// ProfileHeaderTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для отображения информации о профиле
final class ProfileHeaderTableViewCell: UITableViewCell {
    // MARK: Constants

    private enum Constants {
        static let editNameButtonImageName = "profileEditButton"
    }

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Visual Components

    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 80
        imageView.layer.borderColor = UIColor.appMint.cgColor
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdanaBold(withSize: 25)
        label.textColor = .gray
        label.contentMode = .center
        label.textAlignment = .center
        return label
    }()

    private lazy var editNameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: Constants.editNameButtonImageName), for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(showEditingNameAlert), for: .touchUpInside)
        return button
    }()

    // MARK: Public Properties

    var nameChangeHandler: (() -> ())?

    // MARK: Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
        nameLabel.text = nil
    }

    // MARK: Public methods

    func configureCell(imageName: String, userName: String) {
        mainImageView.image = UIImage(named: imageName)
        nameLabel.text = userName
    }

    // MARK: Private Methods

    private func setupHierarchy() {
        [
            mainImageView,
            nameLabel,
            editNameButton
        ].forEach { contentView.addSubview($0) }
    }

    private func setupConstraints() {
        contentView.heightAnchor.constraint(equalToConstant: 290).isActive = true

        setupMainImageViewConstraint()
        setupNameLabelConstraint()
        setupEditNameButtonConstraint()
    }

    private func setupMainImageViewConstraint() {
        NSLayoutConstraint.activate([
            mainImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            mainImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: 160),
            mainImageView.widthAnchor.constraint(equalTo: mainImageView.heightAnchor)
        ])
    }

    private func setupNameLabelConstraint() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setupEditNameButtonConstraint() {
        NSLayoutConstraint.activate([
            editNameButton.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 20),
            editNameButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            editNameButton.heightAnchor.constraint(equalToConstant: 24),
            editNameButton.widthAnchor.constraint(equalToConstant: 24),
            editNameButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 50)
        ])
    }

    @objc private func showEditingNameAlert() {
        nameChangeHandler?()
    }
}
