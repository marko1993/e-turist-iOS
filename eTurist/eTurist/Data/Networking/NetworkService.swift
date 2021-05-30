//
//  NetworkService.swift
//  eTurist
//
//  Created by Marko on 30.05.2021..
//

import Foundation
import RxSwift
import RxCocoa

enum RequestType: String {
    case GET, PUT, POST, DELETE
}

enum NetworkError: Error {
    case badURL, requestFailed, unknown
}

struct BodyParameters: Encodable {
    
}

struct Resources<T: Decodable, P: Encodable> {
    let path: String
    let requestType: RequestType
    let bodyParameters: P?
    let httpHeaderFields: [String : String]?
    let queryParameters: [String : String]?
}


class NetworkService {
    
    public static func performRequest<T: Decodable, P: Encodable>(resources: Resources<T, P>, retryCount: Int) -> Observable<T> {
        
        let pathWithQueryParameters = addQueryParametersToPath(path: resources.path, queryParameters: resources.queryParameters)
        
        guard let url = URL(string: K.Strings.baseUrl + pathWithQueryParameters) else {
            return Observable.error(NetworkError.badURL)
        }
        return Observable
            .just(url)
            .flatMap{url -> Observable<(response: HTTPURLResponse, data: Data)> in
                var request = URLRequest(url: url)
                
                if let bodyParameters = resources.bodyParameters {
                    let jsonData = try? JSONEncoder().encode(bodyParameters)
                    request.httpBody = jsonData
                }
                
                if let headerFields = resources.httpHeaderFields {
                    request.allHTTPHeaderFields = headerFields
                }
                
                request.httpMethod = resources.requestType.rawValue
                return URLSession.shared.rx.response(request: request)
            }.map { response, data -> T in
                if 200..<300 ~= response.statusCode {
                    do {
                        return try JSONDecoder().decode(T.self, from: data)
                    } catch {
                        throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
                    }
                }
                throw RxCocoaURLError.httpRequestFailed(response: response, data: data)
            }.observeOn(MainScheduler.instance)
            .retry(retryCount)
            .asObservable()
    }
    
    private static func addQueryParametersToPath(path: String, queryParameters: [String : String]?) -> String {
        var newPath = path
        if let queryParameters = queryParameters {
            newPath.append("?")
            queryParameters.forEach { (key, value) in
                newPath = "\(newPath)\(key)=\(value)&"
            }
            newPath.removeLast()
        }
        return newPath
    }
    
}
