// FavoritesCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
class FavoritesCell: RecipeTableViewCell {
    // MARK: Initializer

    var identifierFavoritesCell = "FavoritesCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        arrowButton.isHidden = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        arrowButton.isHidden = true
    }
}
