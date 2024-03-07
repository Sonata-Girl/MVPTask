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

    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 80
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(changeUserAvatar))
        imageView.addGestureRecognizer(tap)
        imageView.layer.borderColor = UIColor().appMint?.cgColor
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .addVerdanaBold(withSize: 25)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()

    private lazy var editNameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: Constants.editNameButtonImageName), for: .normal)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(showEditingNameAlert), for: .touchUpInside)
        return button
    }()

    // MARK: Public Properties

    var nameChangeHandler: VoidHandler?
    var avatarChangeHandler: VoidHandler?

    // MARK: Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
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

    func changeName(userName: String) {
        nameLabel.text = userName
    }

    func changeAvatar(image: UIImage) {
        mainImageView.image = image
    }

    // MARK: Private Methods

    private func setupView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        selectedBackgroundView = backgroundView
    }

    private func setupHierarchy() {
        [
            mainImageView,
            nameLabel,
            editNameButton
        ].forEach { contentView.addSubview($0) }
    }

    private func setupConstraints() {
        contentView.heightAnchor.constraint(equalToConstant: 280).isActive = true

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
            nameLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            nameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 270)
        ])
    }

    private func setupEditNameButtonConstraint() {
        NSLayoutConstraint.activate([
            editNameButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 15),
            editNameButton.heightAnchor.constraint(equalToConstant: 24),
            editNameButton.widthAnchor.constraint(equalToConstant: 24),
            editNameButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            editNameButton.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -25)
        ])
    }

    @objc private func showEditingNameAlert() {
        nameChangeHandler?()
    }

    @objc private func changeUserAvatar() {
        avatarChangeHandler?()
    }
}
