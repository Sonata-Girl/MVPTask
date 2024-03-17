// NoDataPlaceholderViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Класс отвечающий за показ ошибки если данные не загрузились
final class NoDataPlaceholderViewCell: UITableViewCell {
    // MARK: Constant

    enum Constants {
        static let nothingFoundText = "Nothing found"
        static let searchImage = "search"
        static let tryAgainText = "Try entering your query differently"
    }

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Private Property

    private let searchImageView = UIImageView()
    private let nothingFoundLabel = UILabel()
    private let tryAgainLabel = UILabel()

    // MARK: Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        addConstraint()
        setupLabels()
        setupImageView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addView()
        addConstraint()
        setupLabels()
        setupImageView()
    }

    // MARK: Private Method

    private func addView() {
        contentView.addSubview(searchImageView)
        contentView.addSubview(nothingFoundLabel)
        contentView.addSubview(tryAgainLabel)
    }

    private func addConstraint() {
        contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - 120).isActive = true

        nothingFoundLabel.translatesAutoresizingMaskIntoConstraints = false
        nothingFoundLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        nothingFoundLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        nothingFoundLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        nothingFoundLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true

        searchImageView.translatesAutoresizingMaskIntoConstraints = false
        searchImageView.bottomAnchor.constraint(
            equalTo: nothingFoundLabel.topAnchor,
            constant: -17
        ).isActive = true
        searchImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        searchImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        searchImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        tryAgainLabel.translatesAutoresizingMaskIntoConstraints = false
        tryAgainLabel.topAnchor.constraint(equalTo: nothingFoundLabel.bottomAnchor, constant: 25).isActive = true
        tryAgainLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        tryAgainLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        tryAgainLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }

    private func setupImageView() {
        searchImageView.image = UIImage(named: Constants.searchImage)
        searchImageView.contentMode = .center
        searchImageView.backgroundColor = .systemGray6
        searchImageView.layer.cornerRadius = 12
    }

    private func setupLabels() {
        nothingFoundLabel.text = Constants.nothingFoundText
        nothingFoundLabel.textColor = .black
        nothingFoundLabel.font = .addVerdanaBold(withSize: 18)
        nothingFoundLabel.textAlignment = .center

        tryAgainLabel.font = .addVerdana(withSize: 14)
        tryAgainLabel.text = Constants.tryAgainText
        tryAgainLabel.textColor = .systemGray4
    }
}
