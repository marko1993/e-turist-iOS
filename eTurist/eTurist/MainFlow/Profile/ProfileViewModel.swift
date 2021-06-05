//
//  ProfileViewModel.swift
//  eTurist
//
//  Created by Marko on 31.05.2021..
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewModel: BaseViewModel {
    
    let userUpdateSuccess: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var userUpdateSuccessObservable: Observable<Bool> {
        return userUpdateSuccess.asObservable()
    }
    
    func getUser() -> User? {
        return self.repository?.getUser()
    }
    
    func logOut() {
        self.repository?.logUserOut(completion: { [weak self] error, responseCode in
            if let error = error {
                self?.handleNetworkError(error: error, responseCode: responseCode)
            } else {
                self?.logUserOut()
            }
        })
    }
    
    func anonymizeUser() {
        self.repository?.anonymizeUser(completion: { [weak self] error, responseCode in
            if let error = error {
                self?.handleNetworkError(error: error, responseCode: responseCode)
            } else {
                self?.logUserOut()
            }
        })
    }
    
    func presentChangePasswordDialog(delegate: ChangePasswordDialogDelegate) {
        coordinator?.presentChangePasswordViewController(delegate: delegate)
    }
    
    func updateUser(fullName: String?, image: UIImage?) {
        self.repository?.updateUser(fullName: fullName, image: image, completion: { [weak self] error, responseCode in
            if let error = error {
                self?.handleNetworkError(error: error, responseCode: responseCode)
            } else {
                self?.userUpdateSuccess.accept(true)
            }
        })
    }
    
}
