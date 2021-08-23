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
    
    private var didZoomInToUserLocation: Bool = false
    
    private lazy var destinationsRelay: BehaviorRelay<[Destination]> = BehaviorRelay(value: self.route?.routeDestinations ?? [])
    var destinationsObservable: Observable<[Destination]> {
        return destinationsRelay.asObservable()
    }
    
    private var visitedDestinationRelay: BehaviorRelay<Destination?> = BehaviorRelay(value: nil)
    var visitedDestinationObservable: Observable<Destination?> {
        return visitedDestinationRelay.asObservable()
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
    
    func getDestinationById(_ id: Int) -> Destination? {
        return self.route.routeDestinations.first{ $0.id == id }
    }
    
    func getUpdatedCurrentDestination(indexPath: IndexPath) -> Destination? {
        self.currentDestination = route.routeDestinations[indexPath.row]
        return self.currentDestination
    }
    
    func addDestinationToVisited(_ destination: Destination) {
        repository?.addDestinationToVisited(destinationId: destination.id, completion: { [weak self] error, resposneCode in
            if let error = error {
                self?.handleNetworkError(error: error, responseCode: resposneCode)
            } else {
                self?.visitedDestinationRelay.accept(destination)
                
                guard var destinations: [Destination] = self?.destinationsRelay.value else { return }
                destinations.enumerated().forEach({ index, item in
                    if item.id == destination.id {
                        destinations[index].userVisited = true
                    }
                })
                self?.route.routeDestinations = destinations
                self?.destinationsRelay.accept(destinations)
                NotificationCenterService.postUpdateDataBroadcast()
            }
        })
    }
    
    func shouldZoomInToUserLocation() -> Bool {
        if !self.didZoomInToUserLocation {
            self.didZoomInToUserLocation = true
            return true
        }
        return false
    }
    
    func exitMapViewController() {
        self.coordinator?.popTopViewController()
    }
    
}
