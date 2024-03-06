// ShimmerRecipeViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Шаблон ожидания загрузки данных в ячейку рецепта
final class ShimmerRecipeViewCell: UICollectionViewCell, ShimmerLoadable {
    // MARK: - Constants

    enum Constants {
        static let gradientKey = "backgroundColor"
    }

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Private Property

    private let fullImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .systemGray6
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: Life Cycle

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupImageView()
        setupLabel()
        setupContentView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setupImageView()
        setupLabel()
        setupContentView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
//        setupShimmers()
        ""
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: self.layer)
        animations()
//        setupShimmers()
    }

    private func setupContentView() {
        contentView.layer.cornerRadius = 24
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.5
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
        nameLabel.leadingAnchor.constraint(equalTo: fullImageView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: fullImageView.trailingAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: fullImageView.bottomAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width / 5).isActive = true
    }

    private func animations() {
        let fullImageViewGradient = CAGradientLayer()
        fullImageViewGradient.startPoint = CGPoint(x: 0, y: 0.5)
        fullImageViewGradient.endPoint = CGPoint(x: 1, y: 0.5)
        fullImageViewGradient.frame = contentView.bounds
        fullImageView.layer.addSublayer(fullImageViewGradient)

        let fullImageViewGroup = makeAnimationGroup()
        fullImageViewGroup.beginTime = 0.0
        fullImageViewGradient.add(fullImageViewGroup, forKey: Constants.gradientKey)

        let nameLabelGradient = CAGradientLayer()
        nameLabelGradient.startPoint = CGPoint(x: 0, y: 0.5)
        nameLabelGradient.endPoint = CGPoint(x: 1, y: 0.5)
        nameLabelGradient.frame = nameLabel.frame
        nameLabel.layer.addSublayer(nameLabelGradient)

        let nameLabelGroup = makeAnimationGroup(previousGroup: fullImageViewGroup)
        nameLabelGradient.add(nameLabelGroup, forKey: Constants.gradientKey)
    }

    func setupShimmers() {
//        fullImageViewLayer.startPoint = CGPoint(x: 0, y: 0.5)
//        fullImageViewLayer.endPoint = CGPoint(x: 1, y: 0.5)
//        fullImageViewLayer.frame = contentView.bounds
//        fullImageView.layer.addSublayer(fullImageViewLayer)
//
//        bottomViewLayer.startPoint = CGPoint(x: 0, y: 0.5)
//        bottomViewLayer.endPoint = CGPoint(x: 1, y: 0.5)
//        bottomViewLayer.frame = bottomView.bounds
//        bottomView.layer.addSublayer(bottomViewLayer)
//
//        nameLabelLayer.startPoint = CGPoint(x: 0, y: 0.5)
//        nameLabelLayer.endPoint = CGPoint(x: 1, y: 0.5)
//        nameLabelLayer.frame = nameLabel.bounds
//        nameLabel.layer.addSublayer(nameLabelLayer)
//
//        let fullImageViewGroup = makeAnimationGroup()
//        fullImageViewGroup.beginTime = 0.0
//        fullImageViewLayer.add(fullImageViewGroup, forKey: "backgroundColor")
//
//        let bottomViewGroup = makeAnimationGroup(previousGroup: fullImageViewGroup)
//        bottomViewGroup.beginTime = 0.0
//        bottomViewLayer.add(bottomViewGroup, forKey: "backgroundColor")
//
//        let nameLabelGroup = makeAnimationGroup(previousGroup: bottomViewGroup)
//        nameLabelGroup.beginTime = 0.0
//        nameLabelLayer.add(nameLabelGroup, forKey: "backgroundColor")
    }
}
