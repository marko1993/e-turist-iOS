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
        self.changePasswordView.cancelButton.onTap(disposeBag: disposeBag) { [weak self] in
            self?.dismiss(animated: false, completion: nil)
        }
        
        self.changePasswordView.saveButton.onTap(disposeBag: disposeBag) {
            
        }
    }
    
}
