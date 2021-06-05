//
//  ChangePasswordRequestModel.swift
//  eTurist
//
//  Created by Marko on 05.06.2021..
//

import Foundation

struct ChangePasswordRequestModel: Codable {
    let newPassword: String
    let oldPassword: String
}
