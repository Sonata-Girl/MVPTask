// ShimmerLoadable.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol ShimmerLoadable {}

extension ShimmerLoadable {
    func makeAnimationGroup(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
        let animationDuration: CFTimeInterval = 1.5

        let animationFirst = CABasicAnimation(
            keyPath: #keyPath(CAGradientLayer.backgroundColor)
        )
        animationFirst.fromValue = UIColor.systemGray6.cgColor
        animationFirst.toValue = UIColor.white.cgColor
        animationFirst.duration = animationDuration
        animationFirst.beginTime = 0.0

        let animationSecond = CABasicAnimation(
            keyPath: #keyPath(CAGradientLayer.backgroundColor)
        )
        animationSecond.fromValue = UIColor.systemGray4.cgColor
        animationSecond.toValue = UIColor.systemGray5.cgColor
        animationSecond.duration = animationDuration
        animationSecond.beginTime = animationFirst.beginTime + animationFirst.duration

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [animationFirst, animationSecond]
        animationGroup.repeatCount = .greatestFiniteMagnitude
        animationGroup.duration = animationSecond.beginTime + animationSecond.duration
        animationGroup.isRemovedOnCompletion = false

        if let previousGroup {
            animationGroup.beginTime = previousGroup.beginTime + 0.33
        }

        return animationGroup
    }
}
