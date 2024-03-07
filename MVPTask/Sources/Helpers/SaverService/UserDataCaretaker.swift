// UserDataCaretaker.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Класс для сохранения данных пользователя
final class UserDataCaretaker {
    // MARK: Private Properties

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "UserDataProfile"

    // MARK: Public Methods

    func save(userProfile: User) {
        do {
            let data = try encoder.encode(userProfile)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }

    func retrieveUserProfileData() -> User? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }

        do {
            return try decoder.decode(User.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}
