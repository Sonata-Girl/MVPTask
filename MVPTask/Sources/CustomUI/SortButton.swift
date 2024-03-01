// SortButton.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Состояние кнопки сортировки
enum SortButtonState {
    /// Сортировка не выбрана
    case notSelected
    /// Сортировка от меньшего к большему
    case sortLowToHigh
    /// Сортировка от большего к меньшему
    case sortHighToLow
}

/// Тип кнопки сортировки
enum SortType: String {
    /// Фильтрация по времени приготовления
    case time = "Time"
    /// Фильтрация по количеству каллорий
    case calories = "Calories"
}

/// Кнопка сортировки списка для переиспользования
final class SortButton: UIButton {
    // MARK: Constants

    private enum Constants {
        static let selectedLowSortButtonImageName = "filterButtonSelectedLow"
        static let unselectedSortButtonImageName = "filterButtonUnselectedIcon"
    }

    // MARK: Public Properties

    var sortType: SortType?
    var sortButtonState: SortButtonState = .notSelected

    // MARK: Initializers

    init(sortType: SortType) {
        super.init(frame: .zero)
        self.sortType = sortType
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    // MARK: Private Methods

    private func setupButton() {
        guard let sortType else { return }
        setTitle("\(sortType.rawValue) ", for: .normal)
        setTitleColor(.label, for: .normal)
        setTitleColor(.white, for: .selected)
        backgroundColor = .systemGray6
        layer.cornerRadius = 17
        setImage(UIImage(named: Constants.unselectedSortButtonImageName), for: .normal)
        setImage(UIImage(named: Constants.selectedLowSortButtonImageName), for: .selected)
        semanticContentAttribute = .forceRightToLeft
        var config = UIButton.Configuration.plain()
        config.baseBackgroundColor = .clear
        configuration = config
    }
}
