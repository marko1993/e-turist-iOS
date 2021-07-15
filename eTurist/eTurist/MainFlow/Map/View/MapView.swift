//
//  MapView.swift
//  eTurist
//
//  Created by Marko on 05.06.2021..
//

import UIKit
import MapKit

class MapView: UIView, BaseView {
    
    let mapView = MKMapView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func addSubviews() {
        addSubview(mapView)
    }
    
    func styleSubviews() {
        backgroundColor = .white
    }
    
    func positionSubviews() {
        mapView.fillSuperview()
    }
    
    func setMapViewDelegate(delegate: MKMapViewDelegate) {
        mapView.delegate = delegate
    }
    
    func setupMapView() {
        mapView.showsUserLocation = true
    }
    
    func zoomInToLocation(location: CLLocationCoordinate2D, radius: Double) {
        let region = MKCoordinateRegion.init(center: location, latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(region, animated: true)
    }
    
    func setupMarkers(items: [CLLocationCoordinate2D]) {
        items.forEach { coordinate in
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
        }
    }
    
    func resetMap() {
        mapView.removeOverlays(mapView.overlays)
    }
    
    func connectLocations(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D, transportType: MKDirectionsTransportType) {
        let request = createDirectionsRequest(start: start, end: end, transportType: transportType)
        let diresctions = MKDirections(request: request)
        diresctions.calculate { [weak self] response, error in
            guard let response = response else { return }
            for route in response.routes {
                self?.mapView.addOverlay(route.polyline)
                self?.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)
            }
        }
    }
    
    private func createDirectionsRequest(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D, transportType: MKDirectionsTransportType) -> MKDirections.Request {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        request.transportType = transportType
        request.requestsAlternateRoutes = false
        return request
    }
    
}
