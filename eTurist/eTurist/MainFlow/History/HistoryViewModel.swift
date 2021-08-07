//
//  HistoryViewModel.swift
//  eTurist
//
//  Created by Marko on 31.05.2021..
//

import Foundation
import RxSwift
import RxCocoa

class HistoryViewModel: BaseViewModel {
    
    var destinations: [Destination] = []
    private let destinationsRelay: BehaviorRelay<[Destination]> = BehaviorRelay(value: [])
    var destinationsObservable: Observable<[Destination]> {
        return destinationsRelay.asObservable()
    }
    
    func getVisitedDestinations() {
        self.repository?.getVisitedDestinations(completion: { [weak self] response, errorMessage in
            if let error = errorMessage {
                self?.handleNetworkError(error: error, responseCode: response?.status)
            }
            if let responseModel = response?.data {
                self?.destinations = responseModel.visitedDestinations
                self?.destinationsRelay.accept(responseModel.visitedDestinations)
            }
        })
    }
    
    func updateDestinations(routes: [Destination]) {
        self.destinationsRelay.accept(routes)
    }
    
    func filterDestinations(filter: String) {
        if filter.isEmpty {
            destinationsRelay.accept(destinations)
        } else {
            destinationsRelay.accept(destinations.filter{ $0.name.lowercased().contains(filter.lowercased()) })
        }
    }
    
    func presentDestinationDetails(index: Int) {
        self.coordinator?.presentDestinationDetialsScreen(destination: destinationsRelay.value[index])
    }
    
}
