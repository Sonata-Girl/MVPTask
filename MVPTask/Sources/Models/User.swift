// User.swift
// Copyright © RoadMap. All rights reserved.

/// Пользователь
struct User: Codable {
    /// Имя
    var name: String
    /// Фамилия
    var surname: String
    /// Картинки аватара
    var imageBase64: String
    /// Пароль
    var password: String
    /// Логин
    var login: String
}
