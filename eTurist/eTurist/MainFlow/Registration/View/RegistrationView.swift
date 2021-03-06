//
//  RegistrationView.swift
//  eTurist
//
//  Created by Marko on 01.06.2021..
//

import UIKit

class RegistrationView: UIView, BaseView {
    
    let profileImageView = UIImageView(image: UIImage(named: "profilePlaceholder")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: K.Color.main)!))
    let emailTextField = TextField(placeHolder: K.Strings.email)
    let fullNameField = TextField(placeHolder: K.Strings.fullName)
    let passwordTextField = TextField(placeHolder: K.Strings.password)
    let repeatPasswordTextField = TextField(placeHolder: K.Strings.repeatPassword)
    let registerButton = ButtonGradient()
    let alreadyHaveAccountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func addSubviews() {
        addSubview(profileImageView)
        addSubview(emailTextField)
        addSubview(fullNameField)
        addSubview(passwordTextField)
        addSubview(repeatPasswordTextField)
        addSubview(registerButton)
        addSubview(alreadyHaveAccountLabel)
    }
    
    func styleSubviews() {
        backgroundColor = .white
        
        profileImageView.layer.cornerRadius = 70
        profileImageView.clipsToBounds = true
        profileImageView.borderWidth = 5
        profileImageView.borderColor = UIColor(named: K.Color.main)!
        
        passwordTextField.isSecureTextEntry = false
        repeatPasswordTextField.isSecureTextEntry = false
        
        registerButton.setTitle(K.Strings.register, for: .normal)
        registerButton.titleLabel?.font = .systemFont(ofSize: 24)
        
        alreadyHaveAccountLabel.text = K.Strings.alreadyHaveAccount
        alreadyHaveAccountLabel.textColor = UIColor(named: K.Color.main)
    }
    
    func positionSubviews() {
        profileImageView.centerX(inView: self)
        profileImageView.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: 30, width: 140, height: 140)
        
        emailTextField.centerX(inView: self)
        emailTextField.anchor(top: profileImageView.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 60, left: 16, bottom: 20, right: 16))
        
        fullNameField.centerX(inView: self)
        fullNameField.anchor(top: emailTextField.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16))
        
        passwordTextField.centerX(inView: self)
        passwordTextField.anchor(top: fullNameField.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16))
        
        repeatPasswordTextField.centerX(inView: self)
        repeatPasswordTextField.anchor(top: passwordTextField.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16))
        
        registerButton.centerX(inView: self)
        registerButton.anchor(leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: alreadyHaveAccountLabel.topAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 16, bottom: 10, right: 16))
        registerButton.constrainHeight(50)
        
        alreadyHaveAccountLabel.anchor(bottom: self.safeAreaLayoutGuide.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 16, right: 20))
        alreadyHaveAccountLabel.centerX(inView: self)
    }
    
}
