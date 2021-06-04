//
//  BaseViewModel.swift
//  eTurist
//
//  Created by Marko on 30.05.2021..
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {
    let disposeBag = DisposeBag()
    var coordinator: AppCoordinator?
    var repository: MainRepository?
    let errorRelay: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    func logUserOut(error: String? = nil) {
        repository?.removeUserData()
        coordinator?.presentLoginScreen(error: error)
    }
    
    func handleNetworkError(error: String, responseCode: Int? = nil) {
        if responseCode == 401 {
            self.logUserOut(error: error)
        } else {
            self.errorRelay.accept(error)
        }
    }
    
    
}

