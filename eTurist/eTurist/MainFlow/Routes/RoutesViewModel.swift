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
    
    private var routes: [Route] = []
    private let routesRelay: BehaviorRelay<[Route]> = BehaviorRelay(value: [])
    var routesObservable: Observable<[Route]> {
        return routesRelay.asObservable()
    }
    
    private var city: City?
    private var cities: [City]?
    
    func getRoutesForCity(_ city: String) {
        self.repository?.getRoutesForCity(city, completion: { [weak self] responseModel, errorMessage in
            if let error = errorMessage {
                self?.errorRelay.accept(error)
            }
            if let response = responseModel {
                self?.routes = response.cityRoutes
                self?.routesRelay.accept(response.cityRoutes)
                self?.city = response.city
            }
        })
    }
    
    func getAllCities(shouldOpenCityPicker: Bool = false, delegate: CityPickerDialogDelegate? = nil) {
        self.repository?.getAllCities() { [weak self] responseModel, errorMessage in
            if let error = errorMessage {
                self?.errorRelay.accept(error)
            }
            if let response = responseModel {
                self?.cities = response.cities
                if shouldOpenCityPicker {
                    if let delegate = delegate {
                        self?.presentCityPicker(delegate: delegate)
                    }
                }
            }
        }
    }
    
    func updateRoutes(routes: [Route]) {
        self.routesRelay.accept(routes)
    }
    
    func filterRoutes(filter: String) {
        if filter.isEmpty {
            routesRelay.accept(routes)
        } else {
            routesRelay.accept(routes.filter{ $0.name.lowercased().contains(filter.lowercased()) })
        }
    }
    
    func presentMapScreen(route: Route) {
        self.coordinator?.presentMapScreen(route: route)
    }
    
    func presentCityPicker(delegate: CityPickerDialogDelegate) {
        if let cities = cities {
            coordinator?.presentCityPickerViewController(currentCity: self.city, cities: cities, delegate: delegate)
        } else {
            self.getAllCities(shouldOpenCityPicker: true, delegate: delegate)
        }
        
    }
    
}
