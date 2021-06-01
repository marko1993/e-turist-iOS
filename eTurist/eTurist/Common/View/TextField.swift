//
//  TextField.swift
//  eTurist
//
//  Created by Marko on 01.06.2021..
//

import UIKit

class TextField: UITextField {
    
    var textPadding = UIEdgeInsets(
        top: 12,
        left: 12,
        bottom: 12,
        right: 12
    )
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        borderStyle = .roundedRect
        borderColor = UIColor(named: K.Color.main)!
        borderWidth = 1
        textColor = UIColor(named: K.Color.main)!
        backgroundColor = UIColor(white: 1, alpha: 0.2)
        layer.cornerRadius = 5
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor: UIColor(named: K.Color.mainTransparent)!])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
}
