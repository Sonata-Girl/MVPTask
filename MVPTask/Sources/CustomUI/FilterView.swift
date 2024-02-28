// FilterView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Описание источника данных для кнопки
protocol FilterViewDataSource {
    /// Количество элементов
    func filterViewCount(_ filterView: FilterView) -> Int
    /// Заголовок для элемента по индексу
    func filterViewTitle(_ filterView: FilterView, indexPath: IndexPath) -> String
}

/// Коллекция фильтров
final class FilterView: UIControl {
    // MARK: Types

    // MARK: Constants

    private enum Constants {
        static let selectedLowFilterButtonImageName = "filterButtonSelectedLow"
        static let selectedHighFilterButtonImageName = "filterButtonSelectedHigh"
    }

    // MARK: Public Properties

    public var dataSource: FilterViewDataSource? {
        didSet {
            setupView()
        }
    }

    // MARK: Private Properties

    private var buttons: [UIButton] = []
    private var stackView: UIStackView!

    // MARK: Initialazers

    override func layoutSubviews() {
        super.layoutSubviews()
        stackView?.frame = bounds
    }

    // MARK: Private Methods

    private func setupView() {
        guard let count = dataSource?.filterViewCount(self) else { return }

        for item in 0 ..< count {
            let indexPath = IndexPath(row: item, section: 0)
            guard let title = dataSource?.filterViewTitle(self, indexPath: indexPath) else { return }
            let button = FilterButton(title: title)
            button.addTarget(self, action: #selector(selectedButton), for: .touchUpInside)
            button.tag = item
            buttons.append(button)
            addSubview(button)
        }

        stackView = UIStackView(arrangedSubviews: buttons)
        addSubview(stackView)
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setLowToHighStateFilterButton(button: UIButton) {
        button.setImage(UIImage(named: Constants.selectedLowFilterButtonImageName), for: .selected)
    }

    private func setHighToLowStateFilterButton(button: UIButton) {
        button.setImage(UIImage(named: Constants.selectedHighFilterButtonImageName), for: .selected)
    }

    @objc private func selectedButton(sender: UIButton) {
        let index = sender.tag
        guard let button = buttons[index] as? FilterButton else { return }
        switch button.filterState {
        case .notSelected:
            button.filterState = .sortLowToHigh
            setLowToHighStateFilterButton(button: button)
            button.isSelected.toggle()
        case .sortLowToHigh:
            button.filterState = .sortHighToLow
            setHighToLowStateFilterButton(button: button)
        case .sortHighToLow:
            button.filterState = .notSelected
            button.isSelected.toggle()
        }
        button.backgroundColor = button.isSelected ? UIColor().appMint : .systemGray6
    }
}
