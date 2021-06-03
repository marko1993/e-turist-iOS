//
//  LoginViewCotroller.swift
//  eTurist
//
//  Created by Marko on 01.06.2021..
//

import UIKit

class LoginViewCotroller: BaseViewController {
    
    private let loginView = LoginView()
    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(loginView)
        setupBinding()
    }
    
    private func setupBinding() {
        
        loginView.loginButton.onTap(disposeBag: disposeBag) { [weak self] in
            guard let self = self else { return }
            if self.isFormValid() {
                self.viewModel.logUserIn(email: self.loginView.emailTextField.text!, password: self.loginView.passwordTextField.text!)
            } else {
                self.presentInfoDialog(message: K.Strings.allFieldRequired)
            }
        }
        
        loginView.dontHaveAccountLabel.onTap(disposeBag: disposeBag) { [weak self] in
            self?.viewModel.presentRegistrationScreen()
        }
        
        viewModel.errorRelay.asObservable().subscribe(onNext: { [weak self] error in
            if let error = error {
                self?.presentInfoDialog(message: error)
            }
        }).disposed(by: disposeBag)
    }
    
    private func isFormValid() -> Bool {
        guard let email = loginView.emailTextField.text else { return false }
        guard let password = loginView.passwordTextField.text else { return false }
        return !email.isEmpty && !password.isEmpty
    }
    
}
