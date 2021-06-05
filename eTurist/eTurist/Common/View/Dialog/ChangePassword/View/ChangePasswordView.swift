//
//  ChangePasswordView.swift
//  eTurist
//
//  Created by Marko on 05.06.2021..
//

import UIKit

class ChangePasswordView: UIView, BaseView {
    
    let container = UIView()
    let oldPasswordTextField = TextField(placeHolder: K.Strings.oldPassword)
    let newPasswordTextField = TextField(placeHolder: K.Strings.newPassword)
    let cancelButton = UIButton()
    let saveButton = ButtonGradient()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func addSubviews() {
        addSubview(container)
        container.addSubview(oldPasswordTextField)
        container.addSubview(newPasswordTextField)
        container.addSubview(cancelButton)
        container.addSubview(saveButton)
        
    }
    
    func styleSubviews() {
        backgroundColor = UIColor(named: K.Color.backgroundDarkTransparent)
        
        container.backgroundColor = .white
        container.cornerRadius = 20
        container.dropShadow(shadowColor: .black)
        
        cancelButton.setTitle(K.Strings.cancel, for: .normal)
        cancelButton.setTitleColor(UIColor(named: K.Color.main), for: .normal)
        cancelButton.backgroundColor = .white
        cancelButton.dropShadow()
        
        saveButton.setTitle(K.Strings.save, for: .normal)
        saveButton.dropShadow(shadowRadius: 2)
        saveButton.dropShadow()
    }
    
    func positionSubviews() {
        
        container.centerInSuperview()
        container.constrainHeight(250)
        container.anchor(leading: self.safeAreaLayoutGuide.leadingAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        
        oldPasswordTextField.anchor(top: container.topAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 16, bottom: 0, right: 16))
        
        newPasswordTextField.anchor(top: oldPasswordTextField.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 16, bottom: 0, right: 16))
        
        saveButton.anchor(bottom: container.bottomAnchor, trailing: container.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
        saveButton.constrainWidth(100)
        
        cancelButton.anchor(bottom: container.bottomAnchor, trailing: saveButton.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 26))
        cancelButton.constrainWidth(100)
        
    }
    
}
