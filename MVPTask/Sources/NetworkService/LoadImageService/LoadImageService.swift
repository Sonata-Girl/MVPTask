// LoadImageService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис для кеширования изображений
final class LoadImageService: LoadImageServiceProtocol {
    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringCacheData
        config.urlCache = nil

        let session = URLSession(configuration: config)
        session.dataTask(with: url, completionHandler: completion).resume()
    }
}
