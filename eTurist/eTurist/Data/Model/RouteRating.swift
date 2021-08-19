//
//  Rating.swift
//  eTurist
//
//  Created by Marko on 19.08.2021..
//

import Foundation

struct RouteRating: Codable {
    let id: Int
    let userId: Int
    let routeId: Int
    let destinationId: Int?
    let rating: Int
    let modifiedAt: String?
    let createdAt: String?
    let averageRating: String
    let myRating: Int
}
