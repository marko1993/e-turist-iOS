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
        self.repository?.getRoutesForCity(city, completion: { [weak self] response, errorMessage in
            if let error = errorMessage {
                self?.handleNetworkError(error: error, responseCode: response?.status)
            }
            if let responseModel = response?.data {
                self?.routes = responseModel.cityRoutes
                self?.routesRelay.accept(responseModel.cityRoutes)
                self?.city = responseModel.city
            }
        })
    }
    
    func getAllCities(shouldOpenCityPicker: Bool = false, delegate: CityPickerDialogDelegate? = nil) {
        self.repository?.getAllCities() { [weak self] response, errorMessage in
            if let error = errorMessage {
                self?.handleNetworkError(error: error, responseCode: response?.status)
            }
            if let responseModel = response?.data {
                self?.cities = responseModel.cities
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
    
    func presentRouteDetailsScreen(route: Route) {
        self.coordinator?.presentRouteDetialsScreen(route: route)
    }
    
    func presentCityPicker(delegate: CityPickerDialogDelegate) {
        if let cities = cities {
            coordinator?.presentCityPickerViewController(currentCity: self.city, cities: cities, delegate: delegate)
        } else {
            self.getAllCities(shouldOpenCityPicker: true, delegate: delegate)
        }
        
    }
    
}
