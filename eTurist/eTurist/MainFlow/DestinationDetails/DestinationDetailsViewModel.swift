//
//  DestinationDetailsViewModel.swift
//  eTurist
//
//  Created by Marko on 07.08.2021..
//

import Foundation

class DestinationDetailsViewModel: BaseViewModel {
    var destination: Destination!
    
    func exitDetailsScreen() {
        self.coordinator?.popTopViewController()
    }
    
    func showCommentsScreen() {
        self.coordinator?.presentCommentsScreen(destinationId: destination.id, routeId: destination.routeId)
    }
}
