//
//  MapViewController.swift
//  eTurist
//
//  Created by Marko on 05.06.2021..
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: LocationViewController {
    
    private let mapView = MapView()
    var viewModel: MapViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(mapView)
        mapView.setMapViewDelegate(delegate: self)
        locationViewControlleDelegate = self
        checkLocationServices()
    }
   
}

extension MapViewController: MKMapViewDelegate {
    
}

extension MapViewController: LocationViewControllerProtocol {
    func locationViewController(_ controller: LocationViewController, didGetAuthorized: Bool?) {
        mapView.setupMapView()
        if let userLocation = getUserLocation()?.coordinate {
            mapView.zoomInToLocation(location: userLocation, radius: K.MapKeys.zoomRadius)
        }
        startUpdatingLocation()
    }
    
    func locationViewController(_ controller: LocationViewController, didReceive location: CLLocation?) {
        guard let location = location else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        mapView.zoomInToLocation(location: center, radius: K.MapKeys.zoomRadius)
    }
    
}
