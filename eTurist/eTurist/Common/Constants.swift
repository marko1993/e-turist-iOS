//
//  Constants.swift
//  eTurist
//
//  Created by Marko on 30.05.2021..
//

import Foundation

struct K {
    
    struct Strings {
        static let appName = "eTurist"
        static let baseUrl = "https://www.eturist.site/"
        static let dontHaveAccount = "Don't have an account. Register."
        static let alreadyHaveAccount = "Already have an account. Log In."
        static let codeSend = "Verification code was send to your emal."
        static let enterCode = "Please enter code."
        static let email = "Email"
        static let fullName = "Full name"
        static let password = "Password"
        static let repeatPassword = "Repeated password"
        static let oldPassword = "Old password"
        static let newPassword = "New password"
        static let logIn = "Log In"
        static let logOut = "Log Out"
        static let save = "Save"
        static let register = "Register"
        static let confirm = "Confirm"
        static let allFieldRequired = "All fields required."
        static let repeatedPasswordMustMatch = "Repeated password must match."
        static let codeMustContainAllDigits = "Code must contain 6 digits."
        static let changePassword = "Change password"
        static let deleteData = "Delete my data"
        static let ok = "Ok"
        static let cancel = "Cancel"
        static let deleteUserMessage = "User data will be deleted. Are you sure you want to continue?"
        static let passwordSaved = "Password saved successfully"
        static let userUpdatedSuccessfully = "User successfully updated"
        static let enableLocation = "Please enable location services in your settings."
        static let selectCity = "Please select a city"
        static let searchRoutesPlaceholder = "Search routes in city"
        static let searchVisitedDestinationsPlaceholder = "Search visited destinations"
    }
    
    struct Endpoints {
        static let testApi = "api/user/test-route"
        static let logInRoute = "api/user/authentication/login"
        static let registerUserRoute = "api/user/authentication/register"
        static let validateCodeRoute = "api/user/authentication/validate-account"
        static let imageEndpoint = K.Strings.baseUrl + "uploads/"
        static let logOutRoute = "api/user/authentication/logout"
        static let deleteUserDataRoute = "api/user/profile/anonymize-user"
        static let changePasswordRoute = "api/user/profile/change-password"
        static let updateUserRoute = "api/user/profile/update"
        static let getRoutesForCityRoute = "api/user/initial-data"
        static let getVisistedDestinationsRoute = "api/user/destinations/visited-by-user"
        static let getCitiesRoute = "api/user/cities"
    }
    
    struct ApiParams {
        static let identifier = "identifier"
        static let limit = "limit"
        static let email = "email"
        static let fullName = "fullName"
        static let password = "password"
    }
    
    struct Color {
        static let main = "main"
        static let mainTransparent = "mainTransparent"
        static let mainLight = "mainLight"
        static let mainLightTransparent = "mainLightTransparent"
        static let backgroundDarkTransparent = "backgroundDarkTransparent"
        static let backgroundLightTransparent = "backgroundLightTransparent"
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
    
    struct MapKeys {
        static let zoomRadius: Double = 5000
        static let geofenceRadius = 50.0
    }
    
}
