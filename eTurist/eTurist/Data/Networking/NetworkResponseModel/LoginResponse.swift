//
//  LoginResponse.swift
//  eTurist
//
//  Created by Marko on 01.06.2021..
//

import Foundation

struct LoginResponse: Codable {
    let user: User
    let token: String
}
