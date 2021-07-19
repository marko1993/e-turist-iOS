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
        setupBindings()
        checkLocationServices()
    }
    
    private func setupBindings() {
        mapView.backButton.onTap(disposeBag: disposeBag) {
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
        }
        mapView.travelModeSC.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!) {
        if let userLocation = getUserLocation()?.coordinate {
            if let destinationCoordinates = self.viewModel.currentDestination?.coordinates.coordinates {
                mapView.connectLocations(
                    start: userLocation,
                    end: CLLocationCoordinate2D(latitude: destinationCoordinates[0], longitude: destinationCoordinates[1]),
                    transportType: (sender.selectedSegmentIndex == 0) ? .walking : .automobile)
            }
        }
    }
   
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        polylineRenderer.lineWidth = 4
        let renderer = polylineRenderer
        renderer.strokeColor = UIColor(named: K.Color.main)
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "DestinationMarker")
        if annotation is MKUserLocation {
            annotationView.glyphImage = UIImage(named: "walking")
            annotationView.markerTintColor = UIColor(named: K.Color.main)!
        } else {
            annotationView.markerTintColor = annotation.subtitle == "visited" ? UIColor(named: K.Color.main) : UIColor.red
        }
        annotationView.subtitleVisibility = .hidden
        return annotationView
    }
}

extension MapViewController: LocationViewControllerDelegate {
    func locationViewController(_ controller: LocationViewController, didGetAuthorized: Bool?) {
        mapView.setupMapView()
        mapView.setupMarkers(items: self.viewModel.getDestinations())
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
