//
//  ProfileView.swift
//  eTurist
//
//  Created by Marko on 31.05.2021..
//

import UIKit
import SDWebImage

class ProfileView: UIView, BaseView {
    
    let profileImageView = UIImageView(image: UIImage(named: "profilePlaceholder")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: K.Color.main)!))
    let emailLabel = UILabel()
    let changePasswordLabel = UnderlinedLabel()
    let deleteDataLabel = UnderlinedLabel()
    let fullNameTextField = TextField(placeHolder: K.Strings.fullName)
    let saveButton = ButtonGradient()
    let logOutButton = ButtonGradient()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func addSubviews() {
        addSubview(profileImageView)
        addSubview(emailLabel)
        addSubview(changePasswordLabel)
        addSubview(deleteDataLabel)
        addSubview(fullNameTextField)
        addSubview(saveButton)
        addSubview(logOutButton)
    }
    
    func styleSubviews() {
        backgroundColor = .white
        
        profileImageView.layer.cornerRadius = 70
        profileImageView.clipsToBounds = true
        profileImageView.borderWidth = 5
        profileImageView.borderColor = UIColor(named: K.Color.main)!
        
        emailLabel.textAlignment = .center
        emailLabel.textColor = UIColor(named: K.Color.main)
        
        changePasswordLabel.text = K.Strings.changePassword
        changePasswordLabel.textAlignment = .center
        changePasswordLabel.textColor = UIColor(named: K.Color.main)
        
        deleteDataLabel.text = K.Strings.deleteData
        deleteDataLabel.textAlignment = .center
        deleteDataLabel.textColor = UIColor(named: K.Color.main)
        
        saveButton.setTitle(K.Strings.save, for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 24)
        
        logOutButton.setTitle(K.Strings.logOut, for: .normal)
        logOutButton.titleLabel?.font = .systemFont(ofSize: 24)
    }
    
    func positionSubviews() {
        
        profileImageView.centerX(inView: self)
        profileImageView.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: 30, width: 140, height: 140)
        
        emailLabel.centerX(inView: self)
        emailLabel.anchor(top: profileImageView.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 16, bottom: 20, right: 16))
        
        changePasswordLabel.centerX(inView: self)
        changePasswordLabel.anchor(top: emailLabel.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 16, bottom: 20, right: 16))
        
        deleteDataLabel.centerX(inView: self)
        deleteDataLabel.anchor(top: changePasswordLabel.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 16, bottom: 20, right: 16))
        
        fullNameTextField.centerX(inView: self)
        fullNameTextField.anchor(top: deleteDataLabel.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 16, bottom: 0, right: 16))
        
        saveButton.centerX(inView: self)
        saveButton.anchor(leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: logOutButton.topAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16))
        saveButton.constrainHeight(50)
        
        logOutButton.centerX(inView: self)
        logOutButton.anchor(leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 16, bottom: 100, right: 16))
        logOutButton.constrainHeight(50)
    }
    
    func setupView(with user: User) {
        emailLabel.text = user.email
        fullNameTextField.text = user.fullName
        profileImageView.sd_setImage(with: URL(string: K.Endpoints.imageEndpoint + (user.picturePath ?? "")))
    }
    
}
