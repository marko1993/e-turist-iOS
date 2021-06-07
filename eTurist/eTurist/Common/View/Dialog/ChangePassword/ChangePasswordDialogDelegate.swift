//
//  ChangePasswordDialogDelegate.swift
//  eTurist
//
//  Created by Marko on 07.06.2021..
//

import Foundation

protocol ChangePasswordDialogDelegate {
    func ChangePasswordDialog(_ dialog: ChangePasswordViewController, didFinishChangingPassword didFinish: Bool, errorMessage: String?)
}
