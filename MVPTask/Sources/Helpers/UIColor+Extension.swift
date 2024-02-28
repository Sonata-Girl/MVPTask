// UIColor+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для быстрого доступа к добавленным цветам
extension UIColor {
    /// Быстрый доступ к загруженному цвету
    var appMint: UIColor? {
        UIColor(named: "appMint") ?? nil
    }
}
