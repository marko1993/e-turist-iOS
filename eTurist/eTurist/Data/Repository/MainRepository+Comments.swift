//
//  MainRepository+Comments.swift
//  eTurist
//
//  Created by Marko on 08.08.2021..
//

import UIKit

extension MainRepository {
    
    func getComments(routeId: Int, destinationId: Int?, limit: Int = 12, page: Int = 1, completion: @escaping (NetworkResponse<CommentsResponseModel>?, String?) -> Void) {
        
        var resources = Resources<NetworkResponse<CommentsResponseModel>, Empty>(
            path: K.Endpoints.getComments,
            requestType: .GET,
            bodyParameters: nil,
            httpHeaderFields: nil,
            queryParameters: [K.ApiParams.routeId: routeId,
                              K.ApiParams.limit: limit,
                              K.ApiParams.page: page]
        )
        if let destinationId = destinationId {
            resources.queryParameters?[K.ApiParams.destinationId] = destinationId
        }
        self.performRequest(resources: resources, retryCount: 1, needsAuthorization: true, completion: completion)
    }
    
    func postCommentToDestination(routeId: Int, destinationId: Int, comment: String, completion: @escaping (NetworkResponse<PostCommentResponseModel>?, String?) -> Void) {
        
        let resources = Resources<NetworkResponse<PostCommentResponseModel>, PostCommentToDestination>(
            path: K.Endpoints.postCommentToDestination,
            requestType: .POST,
            bodyParameters: PostCommentToDestination(routeId: routeId,
                                                     destinationId: destinationId,
                                                     comment: comment),
            httpHeaderFields: nil,
            queryParameters: nil
        )
        self.performRequest(resources: resources, retryCount: 1, needsAuthorization: true, completion: completion)
    }
    
    func postCommentToRoute(routeId: Int, comment: String, completion: @escaping (NetworkResponse<PostCommentResponseModel>?, String?) -> Void) {
        
        let resources = Resources<NetworkResponse<PostCommentResponseModel>, PostCommentToRoute>(
            path: K.Endpoints.postCommentToRoute,
            requestType: .POST,
            bodyParameters: PostCommentToRoute(routeId: routeId, comment: comment),
            httpHeaderFields: nil,
            queryParameters: nil
        )
        self.performRequest(resources: resources, retryCount: 1, needsAuthorization: true, completion: completion)
    }
    
}

