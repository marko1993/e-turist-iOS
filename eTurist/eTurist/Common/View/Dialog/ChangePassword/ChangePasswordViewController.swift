//
//  ChangePasswordViewController.swift
//  eTurist
//
//  Created by Marko on 05.06.2021..
//

import UIKit

protocol ChangePasswordDialogDelegate {
    func ChangePasswordDialog(_ dialog: ChangePasswordViewController, didFinishChangingPassword didFinish: Bool, errorMessage: String?)
}

class ChangePasswordViewController: BaseViewController {
    
    private let changePasswordView = ChangePasswordView()
    var viewModel: ChangePasswordViewModel!
    var delegate: ChangePasswordDialogDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(changePasswordView)
        setupBinding()
    }
    
    private func setupBinding() {
        
        self.viewModel.errorRelay.asObservable().subscribe(onNext: { [weak self] error in
            guard let self = self else { return }
            self.dismiss(animated: false) {
                if let error = error {
                    self.delegate.ChangePasswordDialog(self, didFinishChangingPassword: false, errorMessage: error)
                }
            }
        }).disposed(by: disposeBag)
        
        self.changePasswordView.cancelButton.onTap(disposeBag: disposeBag) { [weak self] in
            self?.dismiss(animated: false, completion: nil)
        }
        
        self.changePasswordView.saveButton.onTap(disposeBag: disposeBag) { [weak self] in
            self?.viewModel.changePassword(newPassword: self?.changePasswordView.newPasswordTextField.text, oldPassword: self?.changePasswordView.oldPasswordTextField.text)
        }
        
        self.viewModel.successObservable.subscribe(onNext: { [weak self] isSuccessfull in
            guard let self = self else { return }
            if isSuccessfull {
                self.dismiss(animated: false) {
                    self.delegate.ChangePasswordDialog(self, didFinishChangingPassword: true, errorMessage: nil)
                }
            }
        }).disposed(by: disposeBag)
        
    }
    
}
