//
//  MainRepository+Routes.swift
//  eTurist
//
//  Created by Marko on 06.06.2021..
//

import UIKit

extension MainRepository {
    
    func getRoutesForCity(_ city: String, limit: Int = 12, completion: @escaping (NetworkResponse<RoutesResponseModel>?, String?) -> Void) {
        let resources = Resources<NetworkResponse<RoutesResponseModel>, Empty>(
            path: K.Endpoints.getRoutesForCityRoute,
            requestType: .GET,
            bodyParameters: nil,
            httpHeaderFields: nil,
            queryParameters: [K.ApiParams.identifier: city, K.ApiParams.limit: limit]
        )
        self.performRequest(resources: resources, retryCount: 1, needsAuthorization: true, completion: completion)
    }
    
    func getAllCities(completion: @escaping (NetworkResponse<CititesResponseModel>?, String?) -> Void) {
        let resources = Resources<NetworkResponse<CititesResponseModel>, Empty>(
            path: K.Endpoints.getCitiesRoute,
            requestType: .GET,
            bodyParameters: nil,
            httpHeaderFields: nil,
            queryParameters: nil
        )
        self.performRequest(resources: resources, retryCount: 1, needsAuthorization: true, completion: completion)
    }
    
    func postRating(routeId: Int, rating: Int, completion: @escaping (NetworkResponse<PostRatingResponseModel>?, String?) -> Void) {
        let resources = Resources<NetworkResponse<PostRatingResponseModel>, PostRatingRequestModel>(
            path: K.Endpoints.postRating,
            requestType: .POST,
            bodyParameters: PostRatingRequestModel(routeId: routeId, destinationId: nil, rating: rating),
            httpHeaderFields: nil,
            queryParameters: nil
        )
        self.performRequest(resources: resources, retryCount: 1, needsAuthorization: true, completion: completion)
    }
    
}
