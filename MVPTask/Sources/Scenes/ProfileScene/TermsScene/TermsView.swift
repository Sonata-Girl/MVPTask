// TermsView.swift
// Copyright © RoadMap. All rights reserved.

//
//  Created by Sonata Girl on 05.03.2024.
//
import UIKit

/// Протокол для связи вью с контроллером
protocol TermsViewDelegate: AnyObject {
    /// Обработка события закрытия экрана
    func closeScreen()
}

/// Вью соглашения и политики
final class TermsView: UIView {
    // MARK: Constants

    enum Constants {
        static let screenTitle = "Term of use"
        static let closeButtonImage = "closeButton"
        static let lineImageName = "line"
    }

    // MARK: Visual Components

    let handleAreaView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()

    private let lineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Constants.lineImageName)
        return imageView
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: Constants.closeButtonImage), for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()

    private let screenTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.screenTitle
        label.font = .addVerdanaBold(withSize: 20)
        label.textColor = .label
        return label
    }()

    private let mainTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.screenTitle
        label.font = .addVerdana(withSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()

    // MARK: Public Properties

    weak var delegate: TermsViewDelegate?

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setupHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: Public Methods

    func setDescription(text: String) {
        mainTextLabel.text = text
    }

    func setGesture(gestures: [UIGestureRecognizer]) {
        for gesture in gestures {
            handleAreaView.addGestureRecognizer(gesture)
        }
    }

    // MARK: Private Methods

    private func configureView() {
        isUserInteractionEnabled = true
        backgroundColor = .white
        layer.cornerRadius = 30
    }

    private func setupHierarchy() {
        [
            handleAreaView,
            closeButton,
            screenTitleLabel,
            mainTextLabel,
        ].forEach { addSubview($0) }
        handleAreaView.addSubview(lineImageView)
    }

    private func setupConstraints() {
        setupHandleAreaViewConstraint()
        setupCloseButtonConstraint()
        setupScreenTitleLabelConstraint()
        setupMainTextLabelConstraint()
    }

    private func setupHandleAreaViewConstraint() {
        NSLayoutConstraint.activate([
            handleAreaView.topAnchor.constraint(equalTo: topAnchor),
            handleAreaView.leadingAnchor.constraint(equalTo: leadingAnchor),
            handleAreaView.trailingAnchor.constraint(equalTo: trailingAnchor),
            handleAreaView.heightAnchor.constraint(equalToConstant: 20),
        ])

        NSLayoutConstraint.activate([
            lineImageView.topAnchor.constraint(equalTo: handleAreaView.topAnchor, constant: 10),
            lineImageView.centerXAnchor.constraint(equalTo: handleAreaView.centerXAnchor),
            lineImageView.widthAnchor.constraint(equalToConstant: 50),
            lineImageView.heightAnchor.constraint(equalToConstant: 5),
        ])
    }

    private func setupCloseButtonConstraint() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: handleAreaView.bottomAnchor),
            closeButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -20
            ),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
        ])
    }

    private func setupScreenTitleLabelConstraint() {
        NSLayoutConstraint.activate([
            screenTitleLabel.topAnchor.constraint(
                equalTo: closeButton.bottomAnchor,
                constant: 10
            ),
            screenTitleLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 20
            ),
            screenTitleLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -20
            ),
            screenTitleLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    private func setupMainTextLabelConstraint() {
        NSLayoutConstraint.activate([
            mainTextLabel.topAnchor.constraint(equalTo: screenTitleLabel.bottomAnchor, constant: 10),
            mainTextLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 25
            ),
            mainTextLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -25
            ),
            mainTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
        ])
    }

    @objc private func closeButtonTapped() {
        delegate?.closeScreen()
    }
}
