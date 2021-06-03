//
//  LoginViewModel.swift
//  eTurist
//
//  Created by Marko on 01.06.2021..
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: BaseViewModel {
    
    func logUserIn(email: String, password: String) {
        self.repository?.logUserIn(email: email, password: password, completion: { [weak self] errorMessage in
            if let error = errorMessage {
                self?.errorRelay.accept(error)
            } else {
                self?.presentHomeScreen()
            }
        })
    }
    
    func presentHomeScreen() {
        self.coordinator?.presentHomeScreen()
    }
    
    func presentRegistrationScreen() {
        self.coordinator?.presentRegistrationScreen()
    }
    
}
