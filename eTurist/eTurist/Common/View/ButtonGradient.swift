//
//  ButtonGradient.swift
//  eTurist
//
//  Created by Marko on 01.06.2021..
//

import UIKit

class ButtonGradient: UIButton {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let gradientLayer = CAGradientLayer()
        let topColor = UIColor(named: K.Color.main)!
        let bottomColor = UIColor(named: K.Color.mainLight)!
        
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.cornerRadius = 5
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.layer.cornerRadius = 5
        self.cornerRadius = 5
        self.dropShadow(offsetSize: CGSize(width: 3, height: 3))
        gradientLayer.frame = rect
        
    }
    
}
