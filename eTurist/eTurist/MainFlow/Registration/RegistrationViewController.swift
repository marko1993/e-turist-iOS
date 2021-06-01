//
//  RegistrationViewController.swift
//  eTurist
//
//  Created by Marko on 01.06.2021..
//

import UIKit

class RegistrationViewController: BaseViewController {
    
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
    }
    
}
