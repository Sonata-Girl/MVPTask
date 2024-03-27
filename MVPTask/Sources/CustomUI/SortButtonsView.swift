// SortButtonsView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Описание источника данных для вью содержашей кнопки сортировки
protocol SortButtonsViewDataSource: AnyObject {
    /// Количество кнопок сортировки
    func sortButtonsViewCount(_ sortButtonsView: SortButtonsView) -> Int
    /// Заголовок для кнопок по индексу
    func sortButtonsViewTitle(_ sortButtonsView: SortButtonsView, indexPath: IndexPath) -> SortType
}
 
/// Делегат для фильтр вью
protocol SortButtonsViewDelegate: AnyObject {
    /// Метод обработки нажатия кнопок коллекции
    func sortButtonsView(
        _ sortButtonsView: SortButtonsView,
        didSelectRowAt indexPath: IndexPath,
        stateButton: SortButtonState
    )
}

/// Коллекция автоматического создания кнопок сортировки из источника
final class SortButtonsView: UIControl {
    // MARK: Constants

    private enum Constants {
        static let selectedLowFilterButtonImageName = "filterButtonSelectedLow"
        static let selectedHighFilterButtonImageName = "filterButtonSelectedHigh"
    }

    // MARK: Public Properties

    public var dataSource: SortButtonsViewDataSource? {
        didSet {
            setupView()
        }
    }

    public var delegate: SortButtonsViewDelegate?

    // MARK: Private Properties

    private var buttons: [SortButton] = []
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()

    // MARK: Initialazers

    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }

    // MARK: Private Methods

    private func setupView() {
        guard let count = dataSource?.sortButtonsViewCount(self) else { return }

        for item in 0 ..< count {
            let indexPath = IndexPath(row: item, section: 0)
            guard let sortType = dataSource?.sortButtonsViewTitle(self, indexPath: indexPath) else { return }
            let button = SortButton(sortType: sortType)
            button.addTarget(self, action: #selector(selectedButton), for: .touchUpInside)
            button.tag = item
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
        addSubview(stackView)
    }

    private func setLowToHighStateFilterButton(button: SortButton) {
        button.sortButtonState = .sortLowToHigh
        button.setImage(UIImage(named: Constants.selectedLowFilterButtonImageName), for: .selected)
    }

    private func setHighToLowStateFilterButton(button: SortButton) {
        button.sortButtonState = .sortHighToLow
        button.setImage(UIImage(named: Constants.selectedHighFilterButtonImageName), for: .selected)
    }

    private func changeStateButton(button: SortButton) {
        switch button.sortButtonState {
        case .notSelected:
            setLowToHighStateFilterButton(button: button)
            button.isSelected.toggle()
        case .sortLowToHigh:
            setHighToLowStateFilterButton(button: button)
        case .sortHighToLow:
            button.sortButtonState = .notSelected
            button.isSelected.toggle()
        }
        button.backgroundColor = button.isSelected ? UIColor().appMint : .systemGray6
    }

    @objc private func selectedButton(sender: SortButton) {
        let index = sender.tag
        let button = buttons[index]
        changeStateButton(button: button)

        delegate?.sortButtonsView(
            self,
            didSelectRowAt: IndexPath(row: index, section: 0),
            stateButton: button.sortButtonState
        )
    }
}
