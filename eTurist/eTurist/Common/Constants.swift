//
//  Constants.swift
//  eTurist
//
//  Created by Marko on 30.05.2021..
//

import Foundation

struct K {
    
    struct Strings {
        static let baseUrl = "https://www.eturist.site/"
        static let dontHaveAccount = "Don't have an account. Register"
        static let alreadyHaveAccount = "Already have an account. Log In"
        static let email = "Email"
        static let password = "Password"
        static let repeatPassword = "Repeated password"
        static let logIn = "Log In"
        static let register = "Register"
    }
    
    struct Endpoints {
        static let testApi = "api/user/test-route"
        static let logInRoute = "api/user/authentication/login"
    }
    
    struct ApiParams {
        static let identifier = "identifier"
    }
    
    struct Color {
        static let main = "main"
        static let mainTransparent = "mainTransparent"
        static let mainLight = "mainLight"
        static let mainLightTransparent = "mainLightTransparent"
    }
    
    struct UserDefaultsKeys {
        static let token = "token"
        static let email = "email"
        static let fullName = "fullName"
        static let picturePath = "picturePath"
        static let id = "id"
        static let isValidated = "isValidated"
        static let modifiedAt = "modifiedAt"
        static let createdAt = "createdAt"
    }
    
}
