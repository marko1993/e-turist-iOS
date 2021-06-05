//
//  MainRepository+User.swift
//  eTurist
//
//  Created by Marko on 05.06.2021..
//

import UIKit

extension MainRepository {
    func logUserIn(email: String, password: String, completion: @escaping (String?) -> Void) {
        let body = LoginRequestModel(email: email, password: password)
        let resources = Resources<NetworkResponse<LoginResponse>, LoginRequestModel>(
            path: K.Endpoints.logInRoute,
            requestType: .POST,
            bodyParameters: body,
            httpHeaderFields: nil,
            queryParameters: nil
        )
        networkService.performRequest(resources: resources, retryCount: 1, needsAuthorization: false)
            .subscribe(onNext: { [weak self] response in
                if let error = response.error {
                    completion(error)
                } else if response.status >= 200 && response.status < 300 {
                    if let data = response.data {
                        self?.userSingleton.saveUser(user: data.user)
                        self?.userSingleton.saveToken(token: data.token)
                    }
                    completion(nil)
                }
            }, onError: { error in
                completion(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    func logUserOut(completion: @escaping (String?, Int?) -> Void) {
        
        let resources = Resources<EmptyNetworkResponse, Empty>(
            path: K.Endpoints.logOutRoute,
            requestType: .POST,
            bodyParameters: nil,
            httpHeaderFields: nil,
            queryParameters: nil
        )
        self.performRequest(resources: resources, retryCount: 1, needsAuthorization: true, completion: completion)
    }
    
    func registerUser(email: String, password: String, fullName: String, image: UIImage?, completion: @escaping (String?) -> Void) {
        let resources = FormDataResources<EmptyNetworkResponse>(
            path: K.Endpoints.registerUserRoute,
            requestType: .POST,
            bodyParameters: [K.ApiParams.email : email, K.ApiParams.password: password, K.ApiParams.fullName: fullName],
            httpHeaderFields: nil,
            queryParameters: nil,
            image: image
        )
        networkService.performRequest(resources: resources, retryCount: 1, needsAuthorization: false)
            .subscribe(onNext: { response in
                if let error = response.error {
                    completion(error)
                } else if response.status >= 200 && response.status < 300 {
                    completion(nil)
                }
            }, onError: { error in
                if error is NetworkError {
                    completion((error as! NetworkError).description)
                } else {
                    completion(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    func updateUser(fullName: String?, image: UIImage?, completion: @escaping (String?, Int?) -> Void) {
        var bodyParams: [String: String]? = nil
        if let fullName = fullName {
            bodyParams = [K.ApiParams.fullName: fullName]
        }
        let resources = FormDataResources<NetworkResponse<UserResponseModel>>(
            path: K.Endpoints.updateUserRoute,
            requestType: .PUT,
            bodyParameters: bodyParams,
            httpHeaderFields: nil,
            queryParameters: nil,
            image: image
        )
        networkService.performRequest(resources: resources, retryCount: 1, needsAuthorization: true)
            .subscribe(onNext: { [weak self]  response in
                if let error = response.error {
                    completion(error, response.status)
                } else if response.status >= 200 && response.status < 300 {
                    if let data = response.data {
                        self?.userSingleton.saveUser(user: data.user)
                    }
                    completion(nil, response.status)
                }
            }, onError: { error in
                if error is NetworkError {
                    completion((error as! NetworkError).description, nil)
                } else {
                    completion(error.localizedDescription, nil)
                }
            }).disposed(by: disposeBag)
    }
    
    func validateCode(email: String, password: String, validationCode: String, completion: @escaping (String?) -> Void) {
        let body = ValidateCodeRequestModel(email: email, password: password, validationCode: validationCode)
        let resources = Resources<NetworkResponse<LoginResponse>, ValidateCodeRequestModel>(
            path: K.Endpoints.validateCodeRoute,
            requestType: .POST,
            bodyParameters: body,
            httpHeaderFields: nil,
            queryParameters: nil
        )
        networkService.performRequest(resources: resources, retryCount: 1, needsAuthorization: false)
            .subscribe(onNext: { [weak self] response in
                if let error = response.error {
                    completion(error)
                } else if response.status >= 200 && response.status < 300 {
                    if let data = response.data {
                        self?.userSingleton.saveUser(user: data.user)
                        self?.userSingleton.saveToken(token: data.token)
                    }
                    completion(nil)
                }
            }, onError: { error in
                completion(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    func anonymizeUser(completion: @escaping (String?, Int?) -> Void) {
        let resources = Resources<EmptyNetworkResponse, Empty>(
            path: K.Endpoints.deleteUserDataRoute,
            requestType: .PUT,
            bodyParameters: nil,
            httpHeaderFields: nil,
            queryParameters: nil
        )
        self.performRequest(resources: resources, retryCount: 1, needsAuthorization: true, completion: completion)
    }
    
    func changePassword(newPassword: String, oldPassword: String, completion: @escaping (String?, Int?) -> Void) {
        let resources = Resources<EmptyNetworkResponse, ChangePasswordRequestModel>(
            path: K.Endpoints.changePasswordRoute,
            requestType: .POST,
            bodyParameters: ChangePasswordRequestModel(newPassword: newPassword, oldPassword: oldPassword),
            httpHeaderFields: nil,
            queryParameters: nil
        )
        self.performRequest(resources: resources, retryCount: 1, needsAuthorization: true, completion: completion)
    }
}
