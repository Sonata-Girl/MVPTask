// UserDataCaretaker.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import Keychain

/// Класс для сохранения данных пользователя
final class UserDataCaretaker {
    // MARK: Constants

    private enum Constants {
        static let key = "UserDataProfile"
        static let passwordKey = "passwordUser"
        static let loginKey = "loginUser"
        static let nameKey = "nameUser"
        static let surnameKey = "surnameUser"
        static let imageKey = "imageUser"
    }

    // MARK: Private Properties

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    // MARK: Public Methods

    func saveUD(userProfile: User) {
        do {
            let data = try encoder.encode(userProfile)
            UserDefaults.standard.set(data, forKey: Constants.key)
        } catch {
            print(error)
        }
    }

    func retrieveUserProfileDataUD() -> User? {
        guard let data = UserDefaults.standard.data(forKey: Constants.key) else {
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
        Keychain.save(userProfile.password, forKey: Constants.passwordKey)
        Keychain.save(userProfile.login, forKey: Constants.loginKey)
        Keychain.save(userProfile.name, forKey: Constants.nameKey)
        Keychain.save(userProfile.surname, forKey: Constants.surnameKey)
        Keychain.save(userProfile.imageBase64, forKey: Constants.imageKey)
    }

    func retrieveUserProfileData() -> User? {
        guard let password = Keychain.load(Constants.passwordKey),
              let login = Keychain.load(Constants.loginKey),
              let name = Keychain.load(Constants.nameKey),
              let surname = Keychain.load(Constants.surnameKey),
              let image = Keychain.load(Constants.imageKey)
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
