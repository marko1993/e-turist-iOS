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
    
    func addDestinationToVisited(destinationId: Int, completion: @escaping (String?, Int?) -> Void) {
        let resources = Resources<EmptyNetworkResponse, AddDestinationToVisitedRequestModel>(
            path: K.Endpoints.addDestinationToVisited,
            requestType: .POST,
            bodyParameters: AddDestinationToVisitedRequestModel(destinationId: destinationId),
            httpHeaderFields: nil,
            queryParameters: nil
        )
        self.performRequest(resources: resources, retryCount: 1, needsAuthorization: true, completion: completion)
    }
}
