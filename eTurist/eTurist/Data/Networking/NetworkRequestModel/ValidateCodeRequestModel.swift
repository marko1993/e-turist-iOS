//
//  ValidateCodeRequestModel.swift
//  eTurist
//
//  Created by Marko on 03.06.2021..
//

import Foundation

struct ValidateCodeRequestModel: Codable {
    let email: String
    let password: String
    let validationCode: String
}
