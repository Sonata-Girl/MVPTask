// ShimmerCellView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Класс для отображения состояния shimmera
class ShimmerCellView: UITableViewCell {
    // MARK: Public Properties

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Visual Components

    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor().appLightMint
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor().appMint?.cgColor
        return view
    }()

    private let shimmerImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        view.layer.borderColor = UIColor().appMint?.cgColor
        view.layer.cornerRadius = 12
        view.isHidden = false
        return view
    }()

    private let shimmerLabel: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        view.layer.borderColor = UIColor().appMint?.cgColor
        view.isHidden = false
        return view
    }()

    private let shimmerLabelMiniLeftView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        view.layer.borderColor = UIColor().appMint?.cgColor
        view.isHidden = false
        return view
    }()

    private let shimmerLabelMiniRightView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        view.layer.borderColor = UIColor().appMint?.cgColor
        view.isHidden = false
        return view
    }()

    // MARK: Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView()
        setupMainTwoViewConstraint()
        setupMainViewConstraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addView()
        setupMainTwoViewConstraint()
        setupMainViewConstraint()
    }

    // MARK: Public Methods

    func startShimmers() {
        layoutIfNeeded()
        startAnimations()
    }

    // MARK: Private Methods

    private func addView() {
        contentView.addSubview(mainView)
        mainView.addSubview(shimmerLabelMiniRightView)
        mainView.addSubview(shimmerLabelMiniLeftView)
        mainView.addSubview(shimmerImageView)
        mainView.addSubview(shimmerLabel)
    }

    private func setupMainViewConstraint() {
        contentView.heightAnchor.constraint(equalToConstant: 114).isActive = true

        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
        ])
    }

    private func setupMainTwoViewConstraint() {
        NSLayoutConstraint.activate([
            shimmerImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            shimmerImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            shimmerImageView.heightAnchor.constraint(equalToConstant: 80),
            shimmerImageView.widthAnchor.constraint(equalToConstant: 80),

            shimmerLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            shimmerLabel.leadingAnchor.constraint(equalTo: shimmerImageView.trailingAnchor, constant: 20),
            shimmerLabel.heightAnchor.constraint(equalToConstant: 32),
            shimmerLabel.widthAnchor.constraint(equalToConstant: 197),

            shimmerLabelMiniLeftView.topAnchor.constraint(equalTo: shimmerLabel.bottomAnchor, constant: 8),
            shimmerLabelMiniLeftView.leadingAnchor.constraint(equalTo: shimmerImageView.trailingAnchor, constant: 20),
            shimmerLabelMiniLeftView.widthAnchor.constraint(equalToConstant: 74),
            shimmerLabelMiniLeftView.heightAnchor.constraint(equalToConstant: 15),

            shimmerLabelMiniRightView.topAnchor.constraint(equalTo: shimmerLabel.bottomAnchor, constant: 8),
            shimmerLabelMiniRightView.leadingAnchor.constraint(
                equalTo: shimmerLabelMiniLeftView.trailingAnchor,
                constant: 10
            ),
            shimmerLabelMiniRightView.widthAnchor.constraint(equalToConstant: 91),
            shimmerLabelMiniRightView.heightAnchor.constraint(equalToConstant: 15),
        ])
    }

    private func startAnimations() {
        shimmerImageView.startShimmeringAnimation(animationSpeed: 2.0)
        shimmerLabelMiniLeftView.startShimmeringAnimation(animationSpeed: 2.0)
        shimmerLabel.startShimmeringAnimation(animationSpeed: 2.0)
        shimmerLabelMiniRightView.startShimmeringAnimation(animationSpeed: 2.0)
    }
}
