// ProxyLoadService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Сервис для кеширования изображений
final class ProxyLoadService: LoadImageServiceProtocol {
    private let cacheImages = NSCache<NSString, CacheImageWrapper>()
    private let fileManager = FileManager.default
    private var service: LoadImageServiceProtocol?

    init(service: LoadImageServiceProtocol) {
        self.service = service
    }

    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let documentDirectory = fileManager.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else { return }

        let imageUrl = documentDirectory.appendingPathComponent(url.lastPathComponent)
        if fileManager.fileExists(atPath: imageUrl.path) {
            do {
                let imageData = try Data(contentsOf: imageUrl)
                completion(imageData, nil, nil)
                return
            } catch {
                completion(nil, nil, error)
                return
            }
        } else {
            service?.loadImage(url: url) { data, response, error in
                guard let data else { return }
                do {
                    try data.write(to: imageUrl)
                    completion(data, response, error)
                } catch {
                    completion(nil, nil, error)
                    return
                }
            }
        }

        if let cachedImage = cacheImages.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage.imageData, nil, nil)
        } else {}
    }

    func loadImageCache(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
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
