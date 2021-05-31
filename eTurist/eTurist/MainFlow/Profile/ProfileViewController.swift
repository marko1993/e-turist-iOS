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
    }
    
}
