//
//  Comment.swift
//  eTurist
//
//  Created by Marko on 08.08.2021..
//

import Foundation

struct Comment: Codable {
    let id: Int
    let userId: Int
    let routeId: Int?
    let modifiedAt: String
    let createdAt: String
    let comment: String
    let isDeleted: Int
    let destinationId: Int?
    let fullName: String
    let email: String
    let picturePath: String?
}
