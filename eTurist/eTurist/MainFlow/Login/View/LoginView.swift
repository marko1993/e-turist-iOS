//
//  LoginView.swift
//  eTurist
//
//  Created by Marko on 01.06.2021..
//

import UIKit

class LoginView: UIView, BaseView {
    
    let logoImageView = UIImageView(image: UIImage(named: "map")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: K.Color.main)!))
    let emailTextField = TextField(placeHolder: K.Strings.email)
    let passwordTextField = TextField(placeHolder: K.Strings.password)
    let loginButton = ButtonGradient()
    let dontHaveAccountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func addSubviews() {
        addSubview(logoImageView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(dontHaveAccountLabel)
    }
    
    func styleSubviews() {
        backgroundColor = .white
        
        loginButton.setTitle(K.Strings.logIn, for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 24)
        
        dontHaveAccountLabel.text = K.Strings.dontHaveAccount
        dontHaveAccountLabel.textColor = UIColor(named: K.Color.main)
    }
    
    func positionSubviews() {
        logoImageView.centerX(inView: self)
        logoImageView.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: 30, width: 120, height: 120)
        
        emailTextField.centerX(inView: self)
        emailTextField.anchor(top: logoImageView.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 60, left: 16, bottom: 20, right: 16))
        
        passwordTextField.centerX(inView: self)
        passwordTextField.anchor(top: emailTextField.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16))
        
        loginButton.centerX(inView: self)
        loginButton.anchor(leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: dontHaveAccountLabel.topAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 16, bottom: 10, right: 16))
        loginButton.constrainHeight(50)
        
        dontHaveAccountLabel.anchor(bottom: self.safeAreaLayoutGuide.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 16, right: 20))
        dontHaveAccountLabel.centerX(inView: self)
    }
    
}
