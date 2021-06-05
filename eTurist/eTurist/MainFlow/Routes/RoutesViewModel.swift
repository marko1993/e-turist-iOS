//
//  RoutesViewModel.swift
//  eTurist
//
//  Created by Marko on 31.05.2021..
//

import Foundation

class RoutesViewModel: BaseViewModel {
    
    func presentMapScreen() {
        coordinator?.presentMapScreen()
    }
    
    func getRoutesForCity(_ city: String) {
        print(city)
    }
    
}
