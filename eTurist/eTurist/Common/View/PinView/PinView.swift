//
//  PinView.swift
//  eTurist
//
//  Created by Marko on 03.06.2021..
//

import UIKit

public protocol OTPViewDelegate {
    func didFinishedEnterCode(code: String)
    func codeNotValid()
}


class PinView: UIView {
    
    let stackView = UIStackView()
    
    var maximumDigits: Int = 6
    var backgroundColour: UIColor = .white
    var shadowColour: UIColor = .darkGray
    var textColor: UIColor = UIColor(named: "main")!
    var font: UIFont = UIFont.boldSystemFont(ofSize: 23)
    public var delegateOTP: OTPViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextFields()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    fileprivate func setupTextFields() {
        backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        stackView.fillSuperview()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        for tag in 1...maximumDigits {
            let textField = PinTextField()
            textField.tag = tag
            stackView.addArrangedSubview(textField)
            setupTextFieldStyle(textField)
        }
    }
    
    fileprivate func setupTextFieldStyle(_ textField: UITextField) {
        textField.delegate = self
        textField.backgroundColor = .white
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.contentHorizontalAlignment = .center
        textField.layer.cornerRadius = 10
        textField.dropShadow(shadowOpacity: 0.6, shadowColor: shadowColour)
        textField.textColor = textColor
        textField.font = font
    }
    
    func getCode() -> String? {
        var code = ""
        stackView.arrangedSubviews.forEach { view in
            if let character = (view as? PinTextField)?.text {
                code.append(character)
            }
        }
        if code.count < maximumDigits { return nil}
        return code
    }
    
}

extension PinView: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var nextTag = 0
        if string.checkBackspace() {
            textField.deleteBackward()
            return false
        } else if string.count == 1
        {
            textField.text = string
            nextTag = textField.tag + 1
        } else if string.count == maximumDigits
        {
            var codePasted = string
            for tag in 1...maximumDigits {
                guard let textfield = viewWithTag(tag) as? UITextField else { continue }
                textfield.text = String(codePasted.removeFirst())
            }
            otpFetch()
        }
        
        if let nextTextfield = viewWithTag(nextTag) as? PinTextField {
            nextTextfield.becomeFirstResponder()
        } else {
            if nextTag > maximumDigits {
                otpFetch()
            }
            endEditing(true)
        }
        return false
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        print("editing")
    }
    
    
    public func otpFetch() {
        var otp = ""
        for tag in 1...maximumDigits {
            guard let textfield = viewWithTag(tag) as? UITextField else { continue }
            otp += textfield.text!
        }
        
        if otp.count == maximumDigits {
            delegateOTP?.didFinishedEnterCode(code: otp)
        } else {
            delegateOTP?.codeNotValid()
        }
    }

}
