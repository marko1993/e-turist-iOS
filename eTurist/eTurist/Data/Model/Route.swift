//
//  Route.swift
//  eTurist
//
//  Created by Marko on 06.06.2021..
//

import Foundation

struct Route: Codable {
    let id: Int
    let name: String
    let description: String?
    let picturePath: String?
    let cityId: Int
    let routeDestinations: [Destination]
    var myRating: Double? = 0.0
    var averageRating: Double?
}
