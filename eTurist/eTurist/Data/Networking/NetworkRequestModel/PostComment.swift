//
//  PostComment.swift
//  eTurist
//
//  Created by Marko on 08.08.2021..
//

import Foundation

struct PostCommentToDestination: Codable {
    let routeId: Int
    let destinationId: Int
    let comment: String
}

struct PostCommentToRoute: Codable {
    let routeId: Int
    let comment: String
}
