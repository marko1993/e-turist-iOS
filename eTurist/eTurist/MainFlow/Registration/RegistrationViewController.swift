//
//  RegistrationViewController.swift
//  eTurist
//
//  Created by Marko on 01.06.2021..
//

import UIKit

class RegistrationViewController: ImagePickerController {
    
    private let registrationView = RegistrationView()
    var viewModel: RegistrationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(registrationView)
        setupBindings()
    }
    
    private func setupBindings() {
        registrationView.alreadyHaveAccountLabel.onTap(disposeBag: disposeBag) {
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
        }
        
        registrationView.profileImageView.onTap(disposeBag: disposeBag) { [weak self] in
            self?.presentImagePicker()
        }
        
        registrationView.registerButton.onTap(disposeBag: disposeBag) { [weak self] in
            guard let self = self else { return }
            if !self.isRepeatedPasswordCorrect() {
                self.presentInfoDialog(message: K.Strings.repeatedPasswordMustMatch)
            } else if !self.isFormValid() {
                self.presentInfoDialog(message: K.Strings.allFieldRequired)
            } else {
                guard let email = self.registrationView.emailTextField.text else { return }
                guard let password = self.registrationView.passwordTextField.text else { return }
                guard let fullName = self.registrationView.fullNameField.text else { return }
                self.viewModel.register(email: email, password: password, fullName: fullName, image: self.registrationView.profileImageView.image)
            }
        }
        
        viewModel.errorRelay.asObservable().subscribe(onNext: { [weak self] error in
            if let error = error {
                self?.presentInfoDialog(message: error)
            }
        }).disposed(by: disposeBag)
        
    }
    
    private func isFormValid() -> Bool {
        guard let email = registrationView.emailTextField.text else { return false }
        guard let password = registrationView.passwordTextField.text else { return false }
        guard let repeatPassword = registrationView.repeatPasswordTextField.text else { return false }
        guard let fullName = registrationView.fullNameField.text else { return false }
        return !email.isEmpty && !password.isEmpty && !repeatPassword.isEmpty && !fullName.isEmpty
    }
    
    private func isRepeatedPasswordCorrect() -> Bool {
        guard let password = registrationView.passwordTextField.text else { return false }
        guard let repeatPassword = registrationView.repeatPasswordTextField.text else { return false }
        if password.isEmpty || repeatPassword.isEmpty { return false }
        return password == repeatPassword
    }
    
    override func onImageSelected(image: UIImage) {
        registrationView.profileImageView.image = image
    }
    
}
