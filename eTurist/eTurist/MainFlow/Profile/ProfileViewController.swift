//
//  ProfileViewController.swift
//  eTurist
//
//  Created by Marko on 31.05.2021..
//

import UIKit

class ProfileViewController: ImagePickerController {
    
    private let profileView = ProfileView()
    var viewModel: ProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(profileView)
        if let user = self.viewModel.getUser() {
            profileView.setupView(with: user)
        }
        setupBinding()
    }
    
    private func setupBinding() {
        
        self.profileView.profileImageView.onTap(disposeBag: disposeBag) { [weak self] in
            self?.presentImagePicker()
        }
        
        self.profileView.changePasswordLabel.onTap(disposeBag: disposeBag) { [weak self] in
            guard let self = self else { return }
            self.viewModel.presentChangePasswordDialog(delegate: self)
        }
        
        self.profileView.deleteDataLabel.onTap(disposeBag: disposeBag) { [weak self] in
            self?.presentConfirmationDialog(description: K.Strings.deleteUserMessage, completion: {
                self?.viewModel.anonymizeUser()
            })
        }
        
        self.profileView.logOutButton.onTap(disposeBag: disposeBag) { [weak self] in
            self?.viewModel.logOut()
        }
        
        self.profileView.saveButton.onTap(disposeBag: disposeBag) { [weak self] in
            self?.viewModel.updateUser(
                fullName: self?.profileView.fullNameTextField.text,
                image: self?.profileView.profileImageView.image)
        }
        
        self.viewModel.errorRelay.asObservable().subscribe(onNext: { [weak self] error in
            if let error = error {
                self?.presentInfoDialog(message: error)
            }
        }).disposed(by: disposeBag)
        
        self.viewModel.userUpdateSuccess.asObservable().subscribe(onNext: { [weak self] isSuccesfull in
            if isSuccesfull {
                self?.presentInfoDialog(message: K.Strings.userUpdatedSuccessfully)
            }
        }).disposed(by: disposeBag)
    }
    
    override func onImageSelected(image: UIImage) {
        profileView.profileImageView.image = image
    }
    
}

extension ProfileViewController: ChangePasswordDialogDelegate {
    func ChangePasswordDialog(_ dialog: ChangePasswordViewController, didFinishChangingPassword didFinish: Bool, errorMessage: String?) {
        if let error = errorMessage {
            presentInfoDialog(message: error)
            return
        }
        if didFinish {
            presentInfoDialog(message: K.Strings.passwordSaved)
        }
    }
    
    
}
