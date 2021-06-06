//
//  MainRepository+Routes.swift
//  eTurist
//
//  Created by Marko on 06.06.2021..
//

import UIKit

extension MainRepository {
    func getRoutesForCity(_ city: String, limit: Int = 12, completion: @escaping (RoutesResponseModel?, String?) -> Void) {
        let resources = Resources<NetworkResponse<RoutesResponseModel>, Empty>(
            path: K.Endpoints.getRoutesForCityRoute,
            requestType: .GET,
            bodyParameters: nil,
            httpHeaderFields: nil,
            queryParameters: [K.ApiParams.identifier: city, K.ApiParams.limit: limit]
        )
        self.performRequest(resources: resources, retryCount: 1, needsAuthorization: true, completion: completion)
    }
}
