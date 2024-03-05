// ProfileViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран профиля пользователя
final class ProfileViewController: UIViewController {
    // MARK: Types

    private enum TableSections {
        case profileHeader
        case profileInfo
    }

    // MARK: Constants

    enum Constants {
        static let screenTitle = "Profile"
    }

    // MARK: Visual Components

    private let screenTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.screenTitle
        label.font = .setVerdanaBold(withSize: 28)
        label.textColor = .label
        return label
    }()

    private lazy var profileTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(
            ProfileHeaderTableViewCell.self,
            forCellReuseIdentifier: ProfileHeaderTableViewCell.identifier
        )
        tableView.register(
            ProfileInfoTableViewCell.self,
            forCellReuseIdentifier: ProfileInfoTableViewCell.identifier
        )

        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    private let imagePicker = ImagePicker()

    // MARK: Public Properties

    var presenter: ProfileViewPresenterProtocol?

    // MARK: Private Properties

    private var tableSections: [TableSections] = [.profileHeader, .profileInfo]

    private var termsView: TermsView?
    private var visualEffectView: UIVisualEffectView?

    private let termsScreenHeight: CGFloat = 750
    private let termsScreenAreaHeight: CGFloat = 30
    private var tabBatHeight: CGFloat = 0

    private var nextStateTermsView: TermsViewState {
        termsVisible ? .collapsed : .expanded
    }

    private var termsVisible = false

    private var runningAnimations: [UIViewPropertyAnimator] = []
    private var animationProgressWhenInterrupted: CGFloat = 0

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
        setupHierarchy()
        setupConstraints()
    }

    // MARK: Private Methods

    private func configureNavigationBar() {
        let buttonBar = UIBarButtonItem(customView: screenTitleLabel)
        navigationItem.leftBarButtonItem = buttonBar
    }

    private func configureView() {
        view.backgroundColor = .white
    }

    private func setupHierarchy() {
        view.addSubview(profileTableView)
    }

    private func setupConstraints() {
        setupProfileTableViewConstraint()
    }

    private func setupProfileTableViewConstraint() {
        NSLayoutConstraint.activate([
            profileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileTableView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 25
            ),
            profileTableView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -25
            ),
            profileTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func showChangeNameAlert() {
        presenter?.showChangeNameInputAlert()
    }

    private func showChangeAvatarPicker() {
        imagePicker.showImagePicker(in: self) { image in
            let cell = self.profileTableView.cellForRow(
                at: IndexPath(row: 0, section: 0)
            ) as? ProfileHeaderTableViewCell
            cell?.changeAvatar(image: image)
        }
    }

    private func showTermsScreen() {
        configureTermsView()
    }
}

// MARK: - UITableViewDataSource

/// ProfileViewController + UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        tableSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter else { return 0 }
        switch tableSections[section] {
        case .profileHeader:
            return 1
        case .profileInfo:
            return presenter.profileInfoCellTypes.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter else { return UITableViewCell() }
        switch tableSections[indexPath.section] {
        case .profileHeader:
            guard let user = presenter.user,
                  let cell = tableView.dequeueReusableCell(
                      withIdentifier: ProfileHeaderTableViewCell.identifier,
                      for: indexPath
                  ) as? ProfileHeaderTableViewCell
            else { return UITableViewCell() }
            cell.configureCell(
                imageName: user.imageName,
                userName: "\(user.surname) \(user.name)"
            )
            cell.nameChangeHandler = { [weak self] in
                self?.showChangeNameAlert()
            }
            cell.avatarChangeHandler = { [weak self] in
                self?.showChangeAvatarPicker()
            }
            return cell
        case .profileInfo:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileInfoTableViewCell.identifier,
                for: indexPath
            ) as? ProfileInfoTableViewCell
            else { return UITableViewCell() }
            cell.configureCell(cellType: presenter.profileInfoCellTypes[indexPath.row])
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

/// ProfileViewController + UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case .profileInfo = tableSections[indexPath.section] {
            guard let presenter else { return }
            switch presenter.profileInfoCellTypes[indexPath.row] {
            case .bonuses:
                presenter.showBonusesScreen()
            case .logOut:
                presenter.showLogOutAlert()
            case .terms:
                showTermsScreen()
            }
        }
    }
}

// MARK: - ProfileViewProtocol

/// ProfileViewController + ProfileViewProtocol
extension ProfileViewController: ProfileViewProtocol {
    func reloadHeaderProfile() {
        profileTableView.reloadRows(at: [IndexPath.SubSequence(row: 0, section: 0)], with: .none)
    }
}

extension ProfileViewController {
    // MARK: Types

    /// Состояния экрана
    private enum TermsViewState {
        /// Развернутый
        case expanded
        /// Свернутый
        case collapsed
    }

    // MARK: Private Methods

    private func configureTermsView() {
        guard let tabBarController else { return }
        tabBatHeight = tabBarController.tabBar.frame.height
        view.backgroundColor = .clear

        visualEffectView = UIVisualEffectView()
        guard let visualEffectView else { return }
        visualEffectView.frame = view.frame
        view.addSubview(visualEffectView)
        termsView = TermsView()
        guard let termsView else { return }
        termsView.setDescription(text: presenter?.termsDescription ?? "")
        tabBarController.view.addSubview(termsView)
        termsView.frame = CGRect(
            x: 0,
            y: view.frame.height - termsScreenAreaHeight,
            width: view.frame.width,
            height: termsScreenHeight
        )
        termsView.clipsToBounds = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTermsViewTap))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleTermsViewPan))
        termsView.setGesture(gestures: [tapGesture, panGesture])
    }

    private func animateTransitionIfNeeded(state: TermsViewState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.termsView?.frame.origin.y =
                        self.view.frame.height - self.termsScreenHeight + self.tabBatHeight
                case .collapsed:
                    self.termsView?.frame.origin.y =
                        self.view.frame.height - self.termsScreenAreaHeight
                }
            }

            frameAnimator.addCompletion { _ in
                self.termsVisible = !self.termsVisible
                self.runningAnimations.removeAll()
            }
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)

            let cornerRadiusAnimator = UIViewPropertyAnimator(
                duration: duration,
                curve: .linear
            ) {
                switch state {
                case .expanded:
                    self.termsView?.layer.cornerRadius = 30
                case .collapsed:
                    self.termsView?.layer.cornerRadius = 0
                }
            }

            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)

            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView?.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView?.effect = nil
                }
            }
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
        }
    }

    private func startInteractive(state: TermsViewState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }

        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }

    private func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }

    private func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }

    private func moveTermsScreen(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: termsView?.handleAreaView)
        var fractionComplete = translation.y / termsScreenHeight
        fractionComplete = termsVisible ? fractionComplete : -fractionComplete
        updateInteractiveTransition(fractionCompleted: fractionComplete)

        if translation.y > termsScreenHeight - tabBatHeight {
            for animator in runningAnimations {
                animator.stopAnimation(false)
                animator.finishAnimation(at: .end)
            }

            runningAnimations.removeAll()
            visualEffectView?.removeFromSuperview()
            termsView?.removeFromSuperview()
            termsView = nil
            visualEffectView = nil
        }
    }

    @objc func handleTermsViewTap(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            animateTransitionIfNeeded(state: nextStateTermsView, duration: 0.9)
        default:
            break
        }
    }

    @objc func handleTermsViewPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractive(state: nextStateTermsView, duration: 0.9)
        case .changed:
            moveTermsScreen(recognizer: recognizer)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
}
