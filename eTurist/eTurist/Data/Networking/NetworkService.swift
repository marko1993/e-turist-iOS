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

struct Empty: Encodable {
    
}

struct Resources<T: Decodable, P: Encodable> {
    let path: String
    let requestType: RequestType
    let bodyParameters: P?
    let httpHeaderFields: [String : String]?
    let queryParameters: [String : String]?
}

struct FormDataResources<T: Decodable> {
    let path: String
    let requestType: RequestType
    let bodyParameters: [String : String]?
    let httpHeaderFields: [String : String]?
    let queryParameters: [String : String]?
    let image: UIImage?
}

class NetworkService {
    
    public func performRequest<T: Decodable, P: Encodable>(resources: Resources<T, P>, retryCount: Int, needsAuthorization: Bool = true) -> Observable<T> {
       
        guard let url = getUrl(path: resources.path, queryParameters: resources.queryParameters) else {
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
                
                if needsAuthorization {
                    if let token = UserDefaults.standard.value(forKey: K.UserDefaultsKeys.token) as? String {
                        request.addValue(token, forHTTPHeaderField: "user-token")
                    }
                }
                
                request.httpMethod = resources.requestType.rawValue
                request.addValue("application/json", forHTTPHeaderField:
                              "Content-Type")
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
    
    public func performRequest<T: Decodable>(resources: FormDataResources<T>, retryCount: Int, needsAuthorization: Bool = true) -> Observable<T> {
       
        guard let url = getUrl(path: resources.path, queryParameters: resources.queryParameters) else {
            return Observable.error(NetworkError.badURL)
        }
        return Observable
            .just(url)
            .flatMap{url -> Observable<(response: HTTPURLResponse, data: Data)> in
                let boundary = "Boundary-\(UUID().uuidString)"
                
                var request = URLRequest(url: url)
                request.httpMethod = resources.requestType.rawValue
                request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                
                let httpBody = NSMutableData()

                if let bodyParams = resources.bodyParameters {
                    for (key, value) in bodyParams {
                        httpBody.appendString(self.convertFormField(named: key, value: value, using: boundary))
                    }
                }
                
                if let imageData = resources.image?.jpegData(compressionQuality: 0.5) {
                    httpBody.append(self.convertFileData(fieldName: "files",
                                                    fileName: "imagename.jpg",
                                                    mimeType: "image/jpg",
                                                    fileData: imageData,
                                                    using: boundary))
                }

                httpBody.appendString("--\(boundary)--")

                request.httpBody = httpBody as Data
                
                if needsAuthorization {
                    if let token = UserDefaults.standard.value(forKey: K.UserDefaultsKeys.token) as? String {
                        request.addValue(token, forHTTPHeaderField: "user-token")
                    }
                }
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
    
    func convertFormField(named name: String, value: String, using boundary: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"

        return fieldString
    }
    
    func convertFileData(fieldName: String, fileName: String, mimeType: String, fileData: Data, using boundary: String) -> Data {
        let data = NSMutableData()

        data.appendString("--\(boundary)\r\n")
        data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
        data.appendString("Content-Type: \(mimeType)\r\n\r\n")
        data.append(fileData)
        data.appendString("\r\n")

        return data as Data
    }
    
    private func getUrl(path: String, queryParameters: [String : String]?) -> URL? {
        let pathWithQueryParameters = addQueryParametersToPath(path: path, queryParameters: queryParameters)
        
        guard let url = URL(string: K.Strings.baseUrl + pathWithQueryParameters) else {
            return nil
        }
        return url
    }
    
    private func addQueryParametersToPath(path: String, queryParameters: [String : String]?) -> String {
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
