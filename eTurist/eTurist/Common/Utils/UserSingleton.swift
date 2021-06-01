//
//  UserSingleton.swift
//  eTurist
//
//  Created by Marko on 01.06.2021..
//

import Foundation

class UserSingleton {
    
    private var user: User? = nil
    private var token: String? = nil
    
    init() {
        initialiseData()
    }
    
    func saveUser(user: User) {
        UserDefaults.standard.set(user.email, forKey: K.UserDefaultsKeys.email)
        UserDefaults.standard.set(user.createdAt, forKey: K.UserDefaultsKeys.createdAt)
        UserDefaults.standard.set(user.modifiedAt, forKey: K.UserDefaultsKeys.modifiedAt)
        UserDefaults.standard.set(user.fullName, forKey: K.UserDefaultsKeys.fullName)
        UserDefaults.standard.set(user.id, forKey: K.UserDefaultsKeys.id)
        UserDefaults.standard.set(user.isValidated, forKey: K.UserDefaultsKeys.isValidated)
        if let picturePath = user.picturePath {
            UserDefaults.standard.set(picturePath, forKey: K.UserDefaultsKeys.picturePath)
        }
        self.user = user
    }
    
    func saveToken(token: String) {
        UserDefaults.standard.set(token, forKey: K.UserDefaultsKeys.token)
        self.token = token
    }
    
    private func initialiseData() {
        self.token = getToken()
        self.user = getUser()
    }
    
    func getToken() -> String? {
        if self.token == nil {
            if let savedToken = UserDefaults.standard.value(forKey: K.UserDefaultsKeys.token) as? String {
                self.token = savedToken
            }
        }
        return self.token
    }
    
    func getUser() -> User? {
        if self.user == nil {
            let email = UserDefaults.standard.value(forKey: K.UserDefaultsKeys.email) as? String
            let createdAt = UserDefaults.standard.value(forKey: K.UserDefaultsKeys.createdAt) as? String
            let modifiedAt = UserDefaults.standard.value(forKey: K.UserDefaultsKeys.modifiedAt) as? String
            let fullName = UserDefaults.standard.value(forKey: K.UserDefaultsKeys.fullName) as? String
            let picturePath = UserDefaults.standard.value(forKey: K.UserDefaultsKeys.picturePath) as? String
            let isValidated = UserDefaults.standard.value(forKey: K.UserDefaultsKeys.isValidated) as? Bool
            let id = UserDefaults.standard.value(forKey: K.UserDefaultsKeys.id) as? Int
            if email == nil || id == nil { return nil }
            self.user = User(id: id!, email: email!, picturePath: picturePath, isValidated: isValidated ?? false, modifiedAt: modifiedAt, createdAt: createdAt, fullName: fullName!)
        }
        return self.user
    }
    
    func isUserLoggedIn() -> Bool {
        return self.token != nil && !self.token!.isEmpty
    }
    
    func logUserOut() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
        self.user = nil
        self.token = nil
    }
    
}
