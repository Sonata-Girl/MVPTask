// UserDataCaretaker.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import Keychain

/// Класс для сохранения данных пользователя
final class UserDataCaretaker {
    // MARK: Private Properties

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "UserDataProfile"
    private let passwordKey = "passwordUser"
    private let loginKey = "loginUser"
    private let nameKey = "nameUser"
    private let surnameKey = "surnameUser"
    private let imageKey = "imageUser"

    // MARK: Public Methods

    func saveUD(userProfile: User) {
        do {
            let data = try encoder.encode(userProfile)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }

    func retrieveUserProfileDataUD() -> User? {
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

    func save(userProfile: User) {
        Keychain.save(userProfile.password, forKey: passwordKey)
        Keychain.save(userProfile.login, forKey: loginKey)
        Keychain.save(userProfile.name, forKey: nameKey)
        Keychain.save(userProfile.surname, forKey: surnameKey)
        Keychain.save(userProfile.imageBase64, forKey: imageKey)
    }

    func retrieveUserProfileData() -> User? {
        guard let password = Keychain.load(passwordKey),
              let login = Keychain.load(loginKey),
              let name = Keychain.load(nameKey),
              let surname = Keychain.load(surnameKey),
              let image = Keychain.load(imageKey)
        else {
            return nil
        }

        return User(
            name: name,
            surname: surname,
            imageBase64: image,
            password: password,
            login: login
        )
    }
}
