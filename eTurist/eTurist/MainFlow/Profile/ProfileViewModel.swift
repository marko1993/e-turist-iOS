//
//  ProfileViewModel.swift
//  eTurist
//
//  Created by Marko on 31.05.2021..
//

import Foundation

class ProfileViewModel: BaseViewModel {
    
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
    
}
