//
//  RoutesViewController.swift
//  eTurist
//
//  Created by Marko on 31.05.2021..
//

import UIKit

class RoutesViewController: LocationViewController {
    
    private let routesView = RoutesView()
    var viewModel: RoutesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(routesView)
        setupBinding()
        checkLocationServices()
    }
    
    override func onPermissionAuthorized() {
        if let userLocation = getUserLocation() {
            geoCoder.reverseGeocodeLocation(userLocation) { [weak self] placemarks, error in
                guard let self = self else { return }
                if let _ = error {
                    return
                }
                if let placemark = placemarks?.first {
                    if let city = placemark.locality?.lowercased().replacingOccurrences(of: "city of ", with: "") {
                        DispatchQueue.main.async {
                            self.viewModel.getRoutesForCity(city)
                        }
                    }
                }
            }
        }
    }
    
    private func setupBinding() {
        routesView.mapButton.onTap(disposeBag: disposeBag) {
            self.viewModel.presentMapScreen()
        }
    }
    
}
