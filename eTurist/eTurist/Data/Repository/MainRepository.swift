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
    
    var networkService: NetworkService!
    var userSingleton: UserSingleton!
    let disposeBag = DisposeBag()
    
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
    
    func registerUser(email: String, password: String, fullName: String, image: UIImage?, completion: @escaping (String?) -> Void) {
        let resources = FormDataResources<EmptyNetworkResponse>(
            path: K.Endpoints.registerUserRoute,
            requestType: .POST,
            bodyParameters: ["email" : email, "password": password, "fullName": fullName],
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
                completion(error.localizedDescription)
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
    
}

