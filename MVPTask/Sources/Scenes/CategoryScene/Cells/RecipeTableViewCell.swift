// RecipeTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для отображения рецетов
class RecipeTableViewCell: UITableViewCell {
    // MARK: Constants

    private enum Constants {
        static let arrowImageName = "rightChevron"
        static let pizzaImageName = "pizzaIcon"
        static let timerImageName = "timerIcon"
        static let minutesTitle = "min"
        static let caloriesTitle = "kkal"
    }

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Visual Components

    lazy var arrowButton: UIImageView = {
        let imageView = makeImageView()
        imageView.image = UIImage(named: Constants.arrowImageName)
        return imageView
    }()

    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor().appLightMint
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor().appMint?.cgColor
        view.isHidden = true
        return view
    }()

    /// моя серая вью shimmer
    private let shimmerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor().appLightGray
        view.layer.borderColor = UIColor().appMint?.cgColor
        view.layer.cornerRadius = 12
        view.isHidden = false
        return view
    }()

    /// моя серая вью shimmer Image
    private let shimmerImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        view.layer.borderColor = UIColor().appMint?.cgColor
        view.layer.cornerRadius = 12
        view.isHidden = false
        return view
    }()

    /// моя серая вью shimmer Label
    private let shimmerLabel: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        view.layer.borderColor = UIColor().appMint?.cgColor
        view.isHidden = false
        return view
    }()

    /// моя серая вью shimmer LabelTwo
    private let shimmerLabelmini: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        view.layer.borderColor = UIColor().appMint?.cgColor
        view.isHidden = false
        return view
    }()

    /// моя серая вью shimmer LabelTwo
    private let shimmerLabelminiTwo: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        view.layer.borderColor = UIColor().appMint?.cgColor
        view.isHidden = false
        return view
    }()

    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = false
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    private lazy var recipeNameLabel: UILabel = {
        let label = makeLabel()
        label.font = .setVerdana(withSize: 14)
        label.numberOfLines = 2
        return label
    }()

    private lazy var timerImageView: UIImageView = {
        let imageView = makeImageView()
        imageView.image = UIImage(named: Constants.timerImageName)
        return imageView
    }()

    private lazy var timerLabel: UILabel = makeLabel()

    private lazy var caloriesImageView: UIImageView = {
        let imageView = makeImageView()
        imageView.image = UIImage(named: Constants.pizzaImageName)
        return imageView
    }()

    private lazy var caloriesLabel: UILabel = makeLabel()

    // MARK: Private Properties

    override var isSelected: Bool {
        didSet {
            mainView.layer.borderWidth = isSelected ? 2 : 0
        }
    }

    private var cellType: ProfileInfoCellTypes?

    // MARK: Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupHierarchy()
        setupConstraints()
        setupTaimer()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: Public methods

    func selectCell() {
        setupStateCell()
    }

    func setupUnselectState() {
        isSelected.toggle()
        mainView.layer.borderWidth = 0
    }

    func configureCell(recipe: Recipe) {
        recipeImageView.image = UIImage(named: recipe.imageName)
        recipeNameLabel.text = recipe.name
        timerLabel.text = "\(recipe.cookingTimeInMinutes) \(Constants.minutesTitle)"
        caloriesLabel.text = "\(recipe.caloriesCount) \(Constants.caloriesTitle)"
    }

    // MARK: Private Methods

    private func setupView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        selectedBackgroundView = backgroundView
    }

    private func setupStateCell() {
        mainView.layer.borderWidth = isSelected ? 2 : 0
    }

    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        return imageView
    }

    private func makeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .setVerdana(withSize: 12)
        label.textColor = .gray
        return label
    }

    private func setupHierarchy() {
        /// моя серая вью
        shimmerView.addSubview(shimmerLabelminiTwo)
        shimmerView.addSubview(shimmerLabelmini)
        shimmerView.addSubview(shimmerImageView)
        shimmerView.addSubview(shimmerLabel)
        contentView.addSubview(shimmerView)
        contentView.addSubview(mainView)
        [
            recipeImageView,
            recipeNameLabel,
            timerImageView,
            timerLabel,
            caloriesImageView,
            caloriesLabel,
            arrowButton
        ].forEach { mainView.addSubview($0) }
    }

    private func setupConstraints() {
        contentView.heightAnchor.constraint(equalToConstant: 114).isActive = true

        setupMainTwoViewConstraint()
        setupMainViewConstraint()
        setupRecipeImageViewConstraint()
        setupRecipeNameLabelConstraint()
        setupTimerImageViewConstraint()
        setupTimerLabelConstraint()
        setupCaloriesImageViewConstraint()
        setupCaloriesLabelConstraint()
        setupArrowButtonConstraint()
    }

    private func setupMainViewConstraint() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
        ])
    }

    /// моя серая вью
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

    private func setupRecipeImageViewConstraint() {
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            recipeImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            recipeImageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
            recipeImageView.widthAnchor.constraint(equalToConstant: 80)

        ])
    }

    private func setupRecipeNameLabelConstraint() {
        NSLayoutConstraint.activate([
            recipeNameLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            recipeNameLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 20),
            recipeNameLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
    }

    private func setupTimerImageViewConstraint() {
        NSLayoutConstraint.activate([
            timerImageView.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 10),
            timerImageView.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 20),
            timerImageView.widthAnchor.constraint(equalToConstant: 15),
            timerImageView.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    private func setupTimerLabelConstraint() {
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 10),
            timerLabel.leadingAnchor.constraint(equalTo: timerImageView.trailingAnchor, constant: 4),
            timerLabel.widthAnchor.constraint(equalToConstant: 60),
            timerLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    private func setupCaloriesImageViewConstraint() {
        NSLayoutConstraint.activate([
            caloriesImageView.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 10),
            caloriesImageView.leadingAnchor.constraint(equalTo: timerLabel.trailingAnchor, constant: 8),
            caloriesImageView.widthAnchor.constraint(equalToConstant: 15),
            caloriesImageView.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    private func setupCaloriesLabelConstraint() {
        NSLayoutConstraint.activate([
            caloriesLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 10),
            caloriesLabel.leadingAnchor.constraint(equalTo: caloriesImageView.trailingAnchor, constant: 4),
            caloriesLabel.widthAnchor.constraint(equalToConstant: 70),
            caloriesLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    private func setupArrowButtonConstraint() {
        NSLayoutConstraint.activate([
            arrowButton.leadingAnchor.constraint(equalTo: recipeNameLabel.trailingAnchor),
            arrowButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            arrowButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            arrowButton.widthAnchor.constraint(equalToConstant: 40),
            arrowButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupTaimer() {
        _ = Timer.scheduledTimer(
            timeInterval: 2.0,
            target: self,
            selector: #selector(fire),
            userInfo: nil,
            repeats: false
        )
    }

    @objc func fire() {
        shimmerView.startShimmeringAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.mainView.isHidden = false
            self.shimmerImageView.isHidden = true
            self.shimmerLabel.isHidden = true
            self.shimmerLabelmini.isHidden = true
            self.shimmerLabelminiTwo.isHidden = true
            self.stopShimmeringAnimation()
        }
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
