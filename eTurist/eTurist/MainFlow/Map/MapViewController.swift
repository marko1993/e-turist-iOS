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
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        self.mapView.resetMap()
        let polylineRenderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        polylineRenderer.lineWidth = 4
        let renderer = polylineRenderer
        renderer.strokeColor = UIColor(named: K.Color.main)
        return renderer
    }
}

extension MapViewController: LocationViewControllerDelegate {
    func locationViewController(_ controller: LocationViewController, didGetAuthorized: Bool?) {
        mapView.setupMapView()
        mapView.setupMarkers(items: self.viewModel.getDestinationsCoordinates())
        if let userLocation = getUserLocation()?.coordinate {
            mapView.zoomInToLocation(location: userLocation, radius: K.MapKeys.zoomRadius)
            
            if let destinationCoordinates = viewModel.getNextUnvisitedDestination(userLocation: CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude))?.coordinates.coordinates {
                mapView.connectLocations(start: userLocation, end: CLLocationCoordinate2D(latitude: destinationCoordinates[0], longitude: destinationCoordinates[1]), transportType: .walking)
            }
        }
        startUpdatingLocation()
    }
    
    func locationViewController(_ controller: LocationViewController, didReceive location: CLLocation?) {
        guard let location = location else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        mapView.zoomInToLocation(location: center, radius: K.MapKeys.zoomRadius)
    }
    
}
