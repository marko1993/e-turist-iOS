//
//  RouteDetailsViewModel.swift
//  eTurist
//
//  Created by Marko on 09.08.2021..
//

import Foundation
import RxSwift
import RxCocoa

class RouteDetailsViewModel: BaseViewModel {
    var route: Route!
    
    private lazy var destinationsRelay: BehaviorRelay<[Destination]> = BehaviorRelay(value: self.route.routeDestinations)
    var destinationsObservable: Observable<[Destination]> {
        return destinationsRelay.asObservable()
    }
    
    private lazy var ratingRelay: BehaviorRelay<RouteRating?> = BehaviorRelay(value: nil)
    var ratingObservable: Observable<RouteRating?> {
        return ratingRelay.asObservable()
    }
    
    func exitDetailsScreen() {
        self.coordinator?.popTopViewController()
    }
    
    func showCommentsScreen() {
        self.coordinator?.presentCommentsScreen(destinationId: nil, routeId: route.id)
    }
    
    func presentMapScreen() {
        self.coordinator?.presentMapScreen(route: route)
    }
    
    func presentDestinationDetails(indexPath: IndexPath) {
        self.coordinator?.presentDestinationDetialsScreen(destination: destinationsRelay.value[indexPath.row])
    }
    
    func updateRating(rating: CGFloat) {
        self.repository?.postRating(routeId: route.id, rating: Int(rating), completion: { [weak self] response, errorMessage in
            if let error = errorMessage {
                self?.handleNetworkError(error: error, responseCode: response?.status)
            }
            if let responseModel = response?.data {
                self?.ratingRelay.accept(responseModel.rating)
            }
        })
    }
    
}
