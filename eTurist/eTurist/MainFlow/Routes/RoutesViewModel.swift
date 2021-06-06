//
//  RoutesViewModel.swift
//  eTurist
//
//  Created by Marko on 31.05.2021..
//

import Foundation
import RxSwift
import RxCocoa

class RoutesViewModel: BaseViewModel {
    
    private let routesRelay: BehaviorRelay<[Route]> = BehaviorRelay(value: [])
    var routesObservable: Observable<[Route]> {
        return routesRelay.asObservable()
    }
    
    private var city: City?
    
    func presentMapScreen(route: Route) {
        self.coordinator?.presentMapScreen(route: route)
    }
    
    func getRoutesForCity(_ city: String) {
        self.repository?.getRoutesForCity(city, completion: { [weak self] responseModel, errorMessage in
            if let error = errorMessage {
                self?.errorRelay.accept(error)
            }
            if let response = responseModel {
                self?.routesRelay.accept(response.cityRoutes)
                self?.city = response.city
            }
        })
    }
    
    func updateRoutes(routes: [Route]) {
        self.routesRelay.accept(routes)
    }
    
}
