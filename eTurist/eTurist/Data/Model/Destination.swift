//
//  Destination.swift
//  eTurist
//
//  Created by Marko on 06.06.2021..
//

import Foundation

struct Destination: Codable {
    let id: Int
    let name: String
    let description: String?
    let picturePath: String?
    let routeId: Int
    var userVisited: Bool
    let coordinates: Point
    var myRating: Double? = 0.0
    var averageRating: Double?
}
