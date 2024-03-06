// ShimmerRecipeViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шаблон ожидания загрузки данных в ячейку рецепта
final class ShimmerRecipeViewCell: UICollectionViewCell {
    // MARK: - Constants

    enum Constants {
        static let gradientKey = "transform.translation.x"
    }

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Visual Components

    private let fullImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        label.clipsToBounds = true
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupImageView()
        setupLabel()
        setupContentView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupImageView()
        setupLabel()
        setupContentView()
    }

    // MARK: Public Methods

    func setupShimmers() {
        layoutIfNeeded()
        animations()
    }

    // MARK: Private Methods

    private func setupContentView() {
        contentView.layer.cornerRadius = 24
        contentView.layer.masksToBounds = true
    }

    private func setupImageView() {
        contentView.addSubview(fullImageView)
        fullImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        fullImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        fullImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        fullImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    private func setupLabel() {
        fullImageView.addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: fullImageView.leadingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: fullImageView.trailingAnchor, constant: -20).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: fullImageView.bottomAnchor, constant: -5).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func animations() {
        let fullImageViewGradient = CAGradientLayer()
        fullImageViewGradient.frame = fullImageView.bounds
        fullImageViewGradient.colors = [
            UIColor.clear.cgColor,
            UIColor().appLightMint?.cgColor,
            UIColor.clear.cgColor
        ]
        fullImageViewGradient.locations = [0, 1]
        let angle = 90 * CGFloat.pi / 180
        fullImageViewGradient.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        fullImageView.layer.addSublayer(fullImageViewGradient)

        let fullImageViewAnimation = CABasicAnimation(keyPath: Constants.gradientKey)
        fullImageViewAnimation.fromValue = -fullImageView.bounds.width
        fullImageViewAnimation.toValue = fullImageView.bounds.width
        fullImageViewAnimation.duration = 1.5
        fullImageViewAnimation.repeatCount = Float.infinity
        fullImageViewGradient.add(fullImageViewAnimation, forKey: Constants.gradientKey)

        let nameLabelGradient = CAGradientLayer()
        nameLabelGradient.frame = nameLabel.bounds
        nameLabelGradient.colors = [
            UIColor.clear.cgColor,
            UIColor().appLightMint?.cgColor,
            UIColor.clear.cgColor
        ]
        nameLabelGradient.locations = [0, 1]
        nameLabelGradient.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        nameLabel.layer.addSublayer(nameLabelGradient)

        let nameLabelAnimation = CABasicAnimation(keyPath: Constants.gradientKey)
        nameLabelAnimation.fromValue = -nameLabel.bounds.width
        nameLabelAnimation.toValue = nameLabel.bounds.width
        nameLabelAnimation.duration = 1.5
        nameLabelAnimation.repeatCount = Float.infinity
        nameLabelGradient.add(nameLabelAnimation, forKey: Constants.gradientKey)
    }
}
