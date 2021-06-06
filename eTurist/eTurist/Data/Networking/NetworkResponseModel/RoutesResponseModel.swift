//
//  RoutesResponseModel.swift
//  eTurist
//
//  Created by Marko on 06.06.2021..
//

import Foundation

struct RoutesResponseModel: Codable {
    let city: City
    let cityRoutes: [Route]
}
