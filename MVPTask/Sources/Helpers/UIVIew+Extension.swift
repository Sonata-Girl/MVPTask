// UIVIew+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширения для добавления градиента
extension UIView {
    /// Направление градиента
    enum Direction: Int {
        /// Сверху вниз
        case topToBottom = 0
        /// Снизу вверх
        case bottomToTop
        /// Слева направо
        case leftToRight
        /// Справа налево
        case rightToLeft
    }

    /// - Parameters:
    ///     - animationSpeed: Скорость анимации
    ///     - direction: Направление анимации
    ///     - repeatCount: Количество повторов
    /// Старт анимации градиента и его добавление на вью
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

    /// Остановка анимации
    func stopShimmeringAnimation() {
        layer.mask = nil
    }
}
