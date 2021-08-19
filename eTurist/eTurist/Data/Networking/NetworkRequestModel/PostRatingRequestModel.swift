//
//  PostRatingRequestModel.swift
//  eTurist
//
//  Created by Marko on 19.08.2021..
//

import Foundation

struct PostRatingRequestModel: Codable {
    let routeId: Int
    let destinationId: Int?
    let rating: Int
}
