// RecipeDescriptionCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для отображения подробного описания рецепта
final class RecipeDescriptionCell: UITableViewCell {
    // MARK: Constants

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Visual Components

    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor().appLightMint
        view.layer.cornerRadius = 20
        return view
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .addVerdana(withSize: 14)
        label.numberOfLines = 0
        label.textColor = .label
        label.layer.cornerRadius = 20
        return label
    }()

    // MARK: Life Cycle

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
        descriptionLabel.text = nil
    }

    // MARK: Public methods

    func configureCell(recipe: Recipe) {
        descriptionLabel.text = recipe.detailDescription
    }

    // MARK: Private Methods

    private func setupView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        selectedBackgroundView = backgroundView
    }

    private func setupHierarchy() {
        contentView.addSubview(mainView)
        mainView.addSubview(descriptionLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 27),
            descriptionLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 27),
            descriptionLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -27),
            descriptionLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -27),
        ])
    }
}
