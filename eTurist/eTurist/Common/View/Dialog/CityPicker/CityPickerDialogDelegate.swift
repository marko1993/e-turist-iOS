//
//  CityPickerDialogDelegate.swift
//  eTurist
//
//  Created by Marko on 07.06.2021..
//

import Foundation

protocol CityPickerDialogDelegate {
    func ChangePasswordDialog(_ dialog: CityPickerViewController, didSelectCity city: City)
}
