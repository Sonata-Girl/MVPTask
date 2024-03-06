// ShimmerCellView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Класс для отображения состояния shimmera
class ShimmerCellView: UITableViewCell {
    // MARK: Public Properties

    var identifiersStateCell = "ShimmerCellView"

    // MARK: Visual Components

    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor().appLightMint
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor().appMint?.cgColor
        return view
    }()

    private let shimmerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor().appLightGray
        view.layer.borderColor = UIColor().appMint?.cgColor
        view.layer.cornerRadius = 12
        view.isHidden = false
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

    private let shimmerLabelmini: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        view.layer.borderColor = UIColor().appMint?.cgColor
        view.isHidden = false
        return view
    }()

    private let shimmerLabelminiTwo: UIView = {
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
    }

    private func addView() {
        shimmerView.addSubview(shimmerLabelminiTwo)
        shimmerView.addSubview(shimmerLabelmini)
        shimmerView.addSubview(shimmerImageView)
        shimmerView.addSubview(shimmerLabel)
        contentView.addSubview(shimmerView)
    }

    private func setupMainViewConstraint() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
        ])
    }

    private func setupMainTwoViewConstraint() {
        NSLayoutConstraint.activate([
            shimmerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            shimmerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            shimmerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            shimmerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            shimmerImageView.topAnchor.constraint(equalTo: shimmerView.topAnchor, constant: 10),
            shimmerImageView.leadingAnchor.constraint(equalTo: shimmerView.leadingAnchor, constant: 10),
            shimmerImageView.bottomAnchor.constraint(equalTo: shimmerView.bottomAnchor, constant: -10),
            shimmerImageView.widthAnchor.constraint(equalToConstant: 80),
            shimmerLabel.topAnchor.constraint(equalTo: shimmerView.topAnchor, constant: 20),
            shimmerLabel.leadingAnchor.constraint(equalTo: shimmerImageView.trailingAnchor, constant: 20),
            shimmerLabel.heightAnchor.constraint(equalToConstant: 32),
            shimmerLabel.widthAnchor.constraint(equalToConstant: 197),
            shimmerLabelmini.topAnchor.constraint(equalTo: shimmerLabel.bottomAnchor, constant: 8),
            shimmerLabelmini.leadingAnchor.constraint(equalTo: shimmerImageView.trailingAnchor, constant: 20),
            shimmerLabelmini.widthAnchor.constraint(equalToConstant: 74),
            shimmerLabelmini.heightAnchor.constraint(equalToConstant: 15),
            shimmerLabelminiTwo.topAnchor.constraint(equalTo: shimmerLabel.bottomAnchor, constant: 8),
            shimmerLabelminiTwo.leadingAnchor.constraint(equalTo: shimmerLabelmini.trailingAnchor, constant: 10),
            shimmerLabelminiTwo.widthAnchor.constraint(equalToConstant: 91),
            shimmerLabelminiTwo.heightAnchor.constraint(equalToConstant: 15),

        ])
    }

    private func startAnimations() {
        shimmerView.startShimmeringAnimation(animationSpeed: 2.0)
        shimmerImageView.startShimmeringAnimation(animationSpeed: 2.0)
        shimmerLabelmini.startShimmeringAnimation(animationSpeed: 2.0)
        shimmerLabel.startShimmeringAnimation(animationSpeed: 2.0)
        shimmerLabelminiTwo.startShimmeringAnimation(animationSpeed: 2.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.mainView.isHidden = false
            self.shimmerImageView.isHidden = true
            self.shimmerLabel.isHidden = true
            self.shimmerLabelmini.isHidden = true
            self.shimmerLabelminiTwo.isHidden = true
            self.stopShimmeringAnimation()
        }
    }

    func configurCell() {
        startAnimations()
    }
}

extension UIView {
    enum Direction: Int {
        case topToBottom = 0
        case bottomToTop
        case leftToRight
        case rightToLeft
    }

    func startShimmeringAnimation(
        animationSpeed: Float = 1.4,
        direction: Direction = .leftToRight,
        repeatCount: Float = MAXFLOAT
    ) {
        let lightColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1).cgColor
        let blackColor = UIColor.black.cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [blackColor, lightColor, blackColor]
        gradientLayer.frame = CGRect(
            x: -bounds.size.width,
            y: -bounds.size.height,
            width: 3 * bounds.size.width,
            height: 3 * bounds.size.height
        )

        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)

        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        }

        gradientLayer.locations = [0.35, 0.50, 0.65]
        layer.mask = gradientLayer

        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = CFTimeInterval(animationSpeed)
        animation.repeatCount = repeatCount
        CATransaction.setCompletionBlock { [weak self] in
            guard let self = self else { return }
            self.layer.mask = nil
        }
        gradientLayer.add(animation, forKey: "shimmerAnimation")
        CATransaction.commit()
    }

    func stopShimmeringAnimation() {
        layer.mask = nil
    }
}
