//
//  ProfileViewController.swift
//  eTurist
//
//  Created by Marko on 31.05.2021..
//

import UIKit

class ProfileViewController: BaseViewController {
    
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
        self.profileView.logOutButton.onTap(disposeBag: disposeBag) { [weak self] in
            self?.viewModel.logOut()
        }
        
        self.viewModel.errorRelay.asObservable().subscribe(onNext: { [weak self] error in
            if let error = error {
                self?.presentInfoDialog(message: error)
            }
        }).disposed(by: disposeBag)
    }
    
}
