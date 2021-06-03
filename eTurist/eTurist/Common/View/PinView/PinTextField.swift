//
//  PinTextField.swift
//  eTurist
//
//  Created by Marko on 03.06.2021..
//

import UIKit

class PinTextField: UITextField {
    
    override func deleteBackward() {
        if self.text?.count == 0 {
            findPrevious()
        } else {
            super.deleteBackward()
            findPrevious()
        }
      
    }
        
    func findPrevious() {
       if let nextField = self.superview?.viewWithTag(self.tag - 1) as? UITextField {
           nextField.becomeFirstResponder()
       } else {
           self.resignFirstResponder()
       }
   }
}
