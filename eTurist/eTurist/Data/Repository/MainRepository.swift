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
    
    func getUser() -> User? {
        return userSingleton.getUser()
    }
    
    func removeUserData() {
        self.userSingleton.logUserOut()
    }
    
    func performRequest<T: Decodable, P: Encodable>(resources: Resources<NetworkResponse<T>, P>, retryCount: Int, needsAuthorization: Bool, completion: @escaping (String?, Int?) -> Void) {
        
        networkService.performRequest(resources: resources, retryCount: 1, needsAuthorization: true)
            .subscribe(onNext: { response in
                if let error = response.error {
                    completion(error, response.status)
                } else if response.status >= 200 && response.status < 300 {
                    completion(nil, response.status)
                }
            }, onError: { error in
                completion(error.localizedDescription, nil)
            }).disposed(by: disposeBag)
        
    }
    
    func performRequest<T: Decodable, P: Encodable>(resources: Resources<NetworkResponse<T>, P>, retryCount: Int, needsAuthorization: Bool, completion: @escaping (T?, String?) -> Void) {
        
        networkService.performRequest(resources: resources, retryCount: 1, needsAuthorization: true)
            .subscribe(onNext: { response in
                if let error = response.error {
                    completion(nil, error)
                } else if response.status >= 200 && response.status < 300 {
                    completion(response.data, nil)
                }
            }, onError: { error in
                completion(nil, error.localizedDescription)
            }).disposed(by: disposeBag)
        
    }
    
    func performRequest<P: Encodable>(resources: Resources<EmptyNetworkResponse, P>, retryCount: Int, needsAuthorization: Bool, completion: @escaping (String?, Int?) -> Void) {
        
        networkService.performRequest(resources: resources, retryCount: 1, needsAuthorization: true)
            .subscribe(onNext: { response in
                if let error = response.error {
                    completion(error, response.status)
                } else if response.status >= 200 && response.status < 300 {
                    completion(nil, response.status)
                }
            }, onError: { error in
                completion(error.localizedDescription, nil)
            }).disposed(by: disposeBag)
        
    }
    
}

