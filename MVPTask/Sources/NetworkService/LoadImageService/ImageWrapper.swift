// ImageWrapper.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Кешированное изображение
final class CacheImageWrapper {
    let imageData: Data?

    init(imageData: Data) {
        self.imageData = imageData
    }
}
