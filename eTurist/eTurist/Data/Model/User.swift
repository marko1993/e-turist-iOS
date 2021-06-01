//
//  User.swift
//  eTurist
//
//  Created by Marko on 01.06.2021..
//

import Foundation

class User: Codable {
    var id: Int
    var email: String
    var picturePath: String?
    var isValidated: Bool
    var modifiedAt: String?
    var createdAt: String?
    let fullName: String
    
    init(id: Int, email: String, picturePath: String? = nil, isValidated: Bool, modifiedAt: String? = nil, createdAt: String? = nil, fullName: String) {
        self.id = id
        self.email = email
        self.picturePath = picturePath
        self.isValidated = isValidated
        self.modifiedAt = modifiedAt
        self.createdAt = createdAt
        self.fullName = fullName
    }
    
}
