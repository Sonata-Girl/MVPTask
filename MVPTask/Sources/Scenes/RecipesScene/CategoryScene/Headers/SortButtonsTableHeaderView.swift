// SortButtonsTableHeaderView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для определения доступных функций делегата
protocol SortButtonsTableHeaderViewDelegate: AnyObject {
    /// Сообщает, что произошла смена сортировки по переданному виду сортировки
    func sortButtonsView(with stateSortButton: SortButtonState, didChangeSortTo sortType: SortType)
}

/// Раздел с кнопками сортировки для списка
final class SortButtonsTableHeaderView: UITableViewHeaderFooterView {
    // MARK: Constants

    enum Constants {}

    static var identifier: String {
        String(describing: self)
    }

    // MARK: Visual Components

    private lazy var sortButtonsView: SortButtonsView = {
        let view = SortButtonsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        return view
    }()

    // MARK: Public Properties

    weak var delegate: SortButtonsTableHeaderViewDelegate?

    // MARK: Private Properties

    private let sortButtonsSource: [SortType] = [
        .calories,
        .time
    ]

    // MARK: Initializers

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHierarchy()
        setupConstraints()
    }

    // MARK: Private Methods

    private func setupHierarchy() {
        contentView.addSubview(sortButtonsView)
    }

    private func setupConstraints() {
        contentView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        setupSortButtonsViewConstraint()
    }

    private func setupSortButtonsViewConstraint() {
        NSLayoutConstraint.activate([
            sortButtonsView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 10
            ),
            sortButtonsView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),
            sortButtonsView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -10
            ),
        ])

        if sortButtonsSource.count * 100 > UIScreen.main.bounds.width.exponent {
            sortButtonsView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ).isActive = true
        } else {
            sortButtonsView.widthAnchor.constraint(
                equalToConstant: CGFloat(sortButtonsSource.count * 100)
            ).isActive = true
        }
    }
}

// MARK: - SortButtonsViewDataSource

/// SortButtonsTableHeaderView + SortButtonsViewDataSource
extension SortButtonsTableHeaderView: SortButtonsViewDataSource {
    func sortButtonsViewCount(_ sortButtonsView: SortButtonsView) -> Int {
        sortButtonsSource.count
    }

    func sortButtonsViewTitle(_ sortButtonsView: SortButtonsView, indexPath: IndexPath) -> SortType {
        sortButtonsSource[indexPath.row]
    }
}

// MARK: - SortButtonsViewDelegate

/// SortButtonsTableHeaderView + SortButtonsViewDelegate
extension SortButtonsTableHeaderView: SortButtonsViewDelegate {
    func sortButtonsView(
        _ sortButtonsView: SortButtonsView,
        didSelectRowAt indexPath: IndexPath,
        stateButton: SortButtonState
    ) {
        delegate?.sortButtonsView(with: stateButton, didChangeSortTo: sortButtonsSource[indexPath.row])
    }
}
