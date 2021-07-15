//
//  MainRepository+Destinations.swift
//  eTurist
//
//  Created by Marko on 06.06.2021..
//

import UIKit

extension MainRepository {
    func getVisitedDestinations(limit: Int = 12, completion: @escaping (NetworkResponse<VisitedDestinationsResponseModel>?, String?) -> Void) {
        let resources = Resources<NetworkResponse<VisitedDestinationsResponseModel>, Empty>(
            path: K.Endpoints.getVisistedDestinationsRoute,
            requestType: .GET,
            bodyParameters: nil,
            httpHeaderFields: nil,
            queryParameters: [K.ApiParams.limit: limit]
        )
        self.performRequest(resources: resources, retryCount: 1, needsAuthorization: true, completion: completion)
    }
}
