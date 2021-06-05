//
//  ChangePasswordViewModel.swift
//  eTurist
//
//  Created by Marko on 05.06.2021..
//

import Foundation
import RxSwift
import RxCocoa

class ChangePasswordViewModel: BaseViewModel {
    
    private let successRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var successObservable: Observable<Bool> {
        return successRelay.asObservable()
    }
    
    func changePassword(newPassword: String?, oldPassword: String?) {
        if !isDataValid(newPassword: newPassword, oldPassword: oldPassword) { return }
        repository?.changePassword(newPassword: newPassword!, oldPassword: oldPassword!, completion: { [weak self] error, resposneCode in
            if let error = error {
                self?.handleNetworkError(error: error)
            } else {
                self?.successRelay.accept(true)
            }
        })
    }
    
    private func isDataValid(newPassword: String?, oldPassword: String?) -> Bool {
        if newPassword == nil || oldPassword == nil || newPassword!.isEmpty || oldPassword!.isEmpty {
            errorRelay.accept(K.Strings.allFieldRequired)
            return false
        }
        return true
    }
    
}
