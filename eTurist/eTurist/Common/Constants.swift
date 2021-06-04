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
        static let dontHaveAccount = "Don't have an account. Register."
        static let alreadyHaveAccount = "Already have an account. Log In."
        static let codeSend = "Verification code was send to your emal."
        static let enterCode = "Please enter code."
        static let email = "Email"
        static let fullName = "Full name"
        static let password = "Password"
        static let repeatPassword = "Repeated password"
        static let logIn = "Log In"
        static let logOut = "Log Out"
        static let save = "Save"
        static let register = "Register"
        static let confirm = "Confirm"
        static let allFieldRequired = "All fields required."
        static let repeatedPasswordMustMatch = "Repeated password must match."
        static let codeMustContainAllDigits = "Code must contain 6 digits."
        static let changePassword = "Change password"
        static let deleteData = "Delete data"
    }
    
    struct Endpoints {
        static let testApi = "api/user/test-route"
        static let logInRoute = "api/user/authentication/login"
        static let registerUserRoute = "api/user/authentication/register"
        static let validateCodeRoute = "api/user/authentication/validate-account"
        static let imageEndpoint = K.Strings.baseUrl + "uploads/"
        static let logOutRoute = "api/user/authentication/logout"
    }
    
    struct ApiParams {
        static let identifier = "identifier"
        static let email = "email"
        static let fullName = "fullName"
        static let password = "password"
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
