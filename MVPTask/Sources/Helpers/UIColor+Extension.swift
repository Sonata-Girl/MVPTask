// UIColor+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для быстрого доступа к добавленным цветам
extension UIColor {
    /// Быстрый доступ к загруженному цвету
    var appMint: UIColor? {
        UIColor(named: "appMint") ?? nil
    }

    /// Быстрый доступ к загруженному цвету
    var appLightMint: UIColor? {
        UIColor(named: "appLightMint") ?? nil
    }
}
