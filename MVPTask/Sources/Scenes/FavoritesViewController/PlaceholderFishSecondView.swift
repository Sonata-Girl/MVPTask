// PlaceholderFishSecondView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Класс отвечающий за показ ошибки если данные не загрузились
final class PlaceholderFishSecondView: UIView {
    // MARK: Constant

    enum Constan {
        static let textLabel = "Start typing text"
        static let searchImage = "search"
        static let verdanaFont = "Verdana"
    }

    // MARK: Private Property

    private let startTextLabel = UILabel()
    private let firstView = UIView()
    private let searchImageView = UIImageView()

    // MARK: Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        addConstraint()
        setupTextLabel()
        setupView()
        setupImageView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addView()
        addConstraint()
        setupTextLabel()
        setupView()
        setupImageView()
    }

    // MARK: Private Method

    private func addView() {
        addSubview(startTextLabel)
        addSubview(firstView)
        firstView.addSubview(searchImageView)
    }

    private func addConstraint() {
        startTextLabel.translatesAutoresizingMaskIntoConstraints = false
        startTextLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        startTextLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        startTextLabel.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: 21
        ).isActive = true
        startTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 435).isActive = true

        firstView.translatesAutoresizingMaskIntoConstraints = false
        firstView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        firstView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        firstView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 159).isActive = true
        firstView.topAnchor.constraint(equalTo: topAnchor, constant: 368).isActive = true

        searchImageView.translatesAutoresizingMaskIntoConstraints = false
        searchImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        searchImageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        searchImageView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 17).isActive = true
        searchImageView.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 17).isActive = true
    }

    private func setupImageView() {
        searchImageView.image = UIImage(named: Constan.searchImage)
    }

    private func setupView() {
        firstView.backgroundColor = #colorLiteral(red: 0.9483424833, green: 0.9605068627, blue: 0.980357763, alpha: 1)
        firstView.layer.cornerRadius = 12
    }

    private func setupTextLabel() {
        startTextLabel.text = Constan.textLabel
        startTextLabel.textColor = .rgba(151, 162, 176, 1)
        startTextLabel.font = .addFont(Constan.verdanaFont, 16)
        startTextLabel.textAlignment = .center
    }
}
