// LoadImageServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Интерфейс сервиса загрузки фотографий
protocol LoadImageServiceProtocol {
    ///  Картинки по url
    /// - Parameters:
    ///     - url: Страница
    ///     - completion: Блок выполнения
    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}
