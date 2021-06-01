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
    
    private let loginSuccesRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var loginSuccesObservable: Observable<Bool> {
        return loginSuccesRelay.asObservable()
    }
    
    func logUserIn(email: String, password: String) {
        self.repository?.logUserIn(email: email, password: password, completion: { [weak self] errorMessage in
            if let error = errorMessage {
                self?.errorRelay.accept(error)
            } else {
                self?.loginSuccesRelay.accept(true)
            }
        })
    }
    
    func presentHomeScreen() {
        self.coordinator?.presentHomeScreen()
    }
    
}
