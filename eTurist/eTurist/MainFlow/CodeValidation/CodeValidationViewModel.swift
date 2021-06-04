//
//  CodeValidationViewModel.swift
//  eTurist
//
//  Created by Marko on 02.06.2021..
//

import Foundation

class CodeValidationViewModel: BaseViewModel {
    
    let email: String
    let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    func varifyCode(code: String) {
        self.repository?.validateCode(email: self.email, password: self.password, validationCode: code, completion: { [weak self] errorMessage in
            if let error = errorMessage {
                self?.handleNetworkError(error: error)
            } else {
                self?.presentHomeScreen()
            }
        })
    }
    
    func presentHomeScreen() {
        coordinator?.presentHomeScreen()
    }
    
}
