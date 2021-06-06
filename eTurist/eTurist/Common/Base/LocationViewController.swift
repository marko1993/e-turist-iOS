//
//  LocationViewController.swift
//  eTurist
//
//  Created by Marko on 05.06.2021..
//

import UIKit
import CoreLocation

protocol LocationViewControllerProtocol {
    func locationViewController(_ controller: LocationViewController, didReceive location: CLLocation?)
    func locationViewController(_ controller: LocationViewController, didGetAuthorized: Bool?)
}

class LocationViewController: BaseViewController {
    
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    
    var locationViewControlleDelegate: LocationViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            presentInfoDialog(message: K.Strings.enableLocation)
        }
    }
    
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            presentInfoDialog(message: K.Strings.enableLocation)
            break
        case .denied:
            locationViewControlleDelegate?.locationViewController(self, didGetAuthorized: false)
            presentInfoDialog(message: K.Strings.enableLocation)
            break
        case .authorizedAlways:
            locationViewControlleDelegate?.locationViewController(self, didGetAuthorized: true)
            locationManager.startUpdatingLocation()
            break
        case .authorizedWhenInUse:
            locationViewControlleDelegate?.locationViewController(self, didGetAuthorized: true)
            break
        @unknown default:
            break
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func getUserLocation() -> CLLocation? {
        return locationManager.location
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }
    
}

extension LocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationViewControlleDelegate?.locationViewController(self, didReceive: locations.last)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
