// ProxyLoadService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис для кеширования изображений
final class ProxyLoadService: LoadImageServiceProtocol {
    private let cacheImages = NSCache<NSString, CacheImageWrapper>()
    private var service: LoadImageServiceProtocol?

    init(service: LoadImageServiceProtocol) {
        self.service = service
    }

    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        if let cachedImage = cacheImages.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage.imageData, nil, nil)
        } else {
            service?.loadImage(url: url) { data, response, error in
                guard let data else { return }
                let cachedImage = CacheImageWrapper(imageData: data)
                self.cacheImages.setObject(
                    cachedImage,
                    forKey: url.absoluteString as NSString
                )
                completion(data, response, error)
            }
        }
    }
}
