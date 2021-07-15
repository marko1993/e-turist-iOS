//
//  MapViewModel.swift
//  eTurist
//
//  Created by Marko on 05.06.2021..
//

import Foundation
import CoreLocation

class MapViewModel: BaseViewModel {
    var route: Route!
    
    func getNextUnvisitedDestination(userLocation: CLLocation) -> Destination? {
        let shortestDistance = route.routeDestinations
            .filter{$0.userVisited != nil && !$0.userVisited!}
            .map{userLocation.distance(from: CLLocation(latitude: $0.coordinates.coordinates[0], longitude: $0.coordinates.coordinates[1]))}
            .sorted()
            .first
        
        let destination = route.routeDestinations.first(where: {userLocation.distance(from: CLLocation(latitude: $0.coordinates.coordinates[0], longitude: $0.coordinates.coordinates[1])) == shortestDistance})
        return destination
    }
    
    func getDestinationsCoordinates() -> [CLLocationCoordinate2D] {
        return route.routeDestinations.map{CLLocationCoordinate2D(latitude: $0.coordinates.coordinates[0], longitude: $0.coordinates.coordinates[1])}
    }
    
}
