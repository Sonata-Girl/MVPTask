// FilterButton.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Состояние кнопки фильтрации
enum FilterButtonState {
    /// Не нажата
    case notSelected
    /// Сортировка от меньшего к большему
    case sortLowToHigh
    /// Сортировка от большего к меньшему
    case sortHighToLow
}

/// Кнопка фильтрации списка для переиспользования
final class FilterButton: UIButton {
    // MARK: Constants

    private enum Constants {
        static let selectedLowFilterButtonImageName = "filterButtonSelectedLow"
        static let selectedHighFilterButtonImageName = "filterButtonSelectedHigh"
        static let unselectedButtonImageName = "filterButtonUnselectedIcon"
    }

    // MARK: Public Properties

    var title: String = ""
    var filterState: FilterButtonState = .notSelected

    // MARK: Initializers

    init(title: String) {
        super.init(frame: .zero)
        self.title = title

        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    // MARK: Private Methods

    private func setupButton() {
        setTitle(title, for: .normal)
        setTitleColor(.label, for: .normal)
        setTitleColor(.white, for: .selected)
        backgroundColor = .systemGray6
        layer.cornerRadius = 17
        setImage(UIImage(named: Constants.unselectedButtonImageName), for: .normal)
        setImage(UIImage(named: Constants.selectedLowFilterButtonImageName), for: .selected)
        semanticContentAttribute = .forceRightToLeft
        var config = UIButton.Configuration.plain()
        config.baseBackgroundColor = .clear
        configuration = config
    }
}
