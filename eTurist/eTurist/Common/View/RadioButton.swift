//
//  RadioButton.swift
//  eTurist
//
//  Created by Marko on 07.06.2021..
//

import UIKit

protocol RadioButtonDelegate: class{
    func RadioButton(_ radioButton: RadioButton, didSelect selected: Bool)
}

class RadioButton: UIButton {
    
    let topView: UIView!
    let innerView: UIView!
    let tagNumber: Int!
    var delegate: RadioButtonDelegate? = nil
    
    init(size: CGSize, isChecked: Bool = false, tagNumber: Int) {
        self.tagNumber = tagNumber
        topView = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        innerView = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
         
        self.setupViews()
        self.styleViews()
        self.setupBinding()
        self.setChecked(isChecked)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(innerView)
        addSubview(topView)
        
        innerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            innerView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            innerView.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            innerView.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.6),
            innerView.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.6)
        ])
        layoutIfNeeded()
        
    }
    
    private func styleViews() {
        topView.backgroundColor = .clear
        
        topView.layer.borderWidth = 1.5
        topView.layer.borderColor = UIColor.gray.cgColor
        topView.layer.cornerRadius = topView.frame.size.width / 2

        innerView.layer.cornerRadius = innerView.frame.size.width / 2
        
    }
    
    private func setupBinding() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(itemTapped(tapGestureRecognizer:)))
        topView.isUserInteractionEnabled = true
        topView.addGestureRecognizer(tap)
        topView.isUserInteractionEnabled = true
    }
    
    @objc func itemTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if let delegate = self.delegate {
            delegate.RadioButton(self, didSelect: true)
        }
    }
    
    func setChecked(_ isChecked: Bool) {
        innerView.backgroundColor = isChecked ? UIColor(named: K.Color.main)! : .clear
    }
    
}

