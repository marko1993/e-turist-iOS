//
//  RegistrationViewModel.swift
//  eTurist
//
//  Created by Marko on 01.06.2021..
//

import Foundation
import RxSwift
import RxCocoa

class RegistrationViewModel: BaseViewModel {
    
    func presentCodeValidationScreen(email: String, password: String) {
        coordinator?.presentCodeValidationScreen(email: email, password: password)
    }
    
    func register(email: String, password: String, fullName: String, image: UIImage?) {
        self.repository?.registerUser(email: email, password: password, fullName: fullName, image: image, completion: { [weak self] errorMessage in
            if let error = errorMessage {
                self?.handleNetworkError(error: error)
            } else {
                self?.presentCodeValidationScreen(email: email, password: password)
            }
        })
    }
    
}
