//
//  MainRepository.swift
//  eTurist
//
//  Created by Marko on 30.05.2021..
//

import Foundation
import RxSwift
import RxCocoa

class MainRepository: Repository {
    
    init() {
        
    }
    
    func getTestRoute(identifier: String?) -> Observable<TestRouteResponse> {
        var queryParams: [String: String]? = nil
        if let identifier = identifier {
            queryParams = [K.ApiParams.identifier: identifier]
        }
        let resources = Resources<TestRouteResponse, String>(path: K.Endpoints.testApi, requestType: .GET, bodyParameters: nil, httpHeaderFields: nil, queryParameters: queryParams)
        
        return NetworkService.performRequest(resources: resources, retryCount: 2)
    }
    
}

