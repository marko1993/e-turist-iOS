//
//  CodeValidationView.swift
//  eTurist
//
//  Created by Marko on 02.06.2021..
//

import UIKit


class CodeValidationView: UIView, BaseView {
    
    let titleLabel = UILabel()
    let enterCodeLabel = UILabel()
    let confirmButton = ButtonGradient()
    let pinView = PinView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(enterCodeLabel)
        addSubview(pinView)
        addSubview(confirmButton)
    }
    
    func styleSubviews() {
        backgroundColor = .white
        
        titleLabel.text = K.Strings.codeSend
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(named: "main")
        
        enterCodeLabel.text = K.Strings.enterCode
        enterCodeLabel.textAlignment = .center
        enterCodeLabel.textColor = UIColor(named: "main")
        
        confirmButton.setTitle(K.Strings.confirm, for: .normal)
        confirmButton.titleLabel?.font = .systemFont(ofSize: 24)
    }
    
    func positionSubviews() {
        titleLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 16, bottom: 0, right: 16))
        
        enterCodeLabel.anchor(top: titleLabel.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 60, left: 16, bottom: 0, right: 16))
        
        pinView.anchor(top: enterCodeLabel.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16))
        pinView.constrainHeight(50)
        
        confirmButton.centerX(inView: self)
        confirmButton.anchor(leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 16, bottom: 40, right: 16))
        confirmButton.constrainHeight(50)
    }
    
}
