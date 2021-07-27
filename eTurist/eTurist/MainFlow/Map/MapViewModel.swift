//
//  MapViewModel.swift
//  eTurist
//
//  Created by Marko on 05.06.2021..
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

class MapViewModel: BaseViewModel {
    var route: Route!
    var currentDestination: Destination? = nil
    
    private lazy var destinationsRelay: BehaviorRelay<[Destination]> = BehaviorRelay(value: self.route?.routeDestinations ?? [])
    var destinationsObservable: Observable<[Destination]> {
        return destinationsRelay.asObservable()
    }
    
    func getNextUnvisitedDestination(userLocation: CLLocation) -> Destination? {
        let shortestDistance = route.routeDestinations
            .filter{$0.userVisited != nil && !$0.userVisited!}
            .map{userLocation.distance(from: CLLocation(latitude: $0.coordinates.coordinates[0], longitude: $0.coordinates.coordinates[1]))}
            .sorted()
            .first
        
        let destination = route.routeDestinations.first(where: {userLocation.distance(from: CLLocation(latitude: $0.coordinates.coordinates[0], longitude: $0.coordinates.coordinates[1])) == shortestDistance})
        self.currentDestination = destination
        return destination
    }
    
    func getDestinations() -> [Destination]? {
        destinationsRelay.accept(route.routeDestinations)
        return route.routeDestinations
    }
    
    func getUpdatedCurrentDestination(indexPath: IndexPath) -> Destination? {
        self.currentDestination = route.routeDestinations[indexPath.row]
        return self.currentDestination
    }
    
}
