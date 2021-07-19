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
    let backButton = UIButton()
    let travelModeSC = UISegmentedControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func addSubviews() {
        addSubview(mapView)
        addSubview(backButton)
        addSubview(travelModeSC)
    }
    
    func styleSubviews() {
        backgroundColor = .white
        backButton.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.imageView?.tintColor = UIColor(named: K.Color.main)
        
        travelModeSC.insertSegment(with: UIImage(named: "walking"), at: 0, animated: true)
        travelModeSC.insertSegment(with: UIImage(named: "driving"), at: 1, animated: true)
        travelModeSC.selectedSegmentIndex = 0
        travelModeSC.backgroundColor = UIColor(named: K.Color.mainLightTransparent)
        travelModeSC.setDimensions(height: 40, width: 100)
    }
    
    func positionSubviews() {
        mapView.fillSuperview()
        
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0))
        backButton.constrainWidth(30)
        backButton.constrainHeight(30)
        
        travelModeSC.anchor(top: safeAreaLayoutGuide.topAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        travelModeSC.centerX(inView: self)
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
    
    func setupMarkers(items: [Destination]?) {
        items?.forEach { destination in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: destination.coordinates.coordinates[0], longitude: destination.coordinates.coordinates[1])
            annotation.title = destination.name
            annotation.subtitle = destination.userVisited ?? false ? "visited" : "not-visited"
            mapView.addAnnotation(annotation)
        }
    }
    
    func resetMap() {
        mapView.removeOverlays(mapView.overlays)
    }
    
    func connectLocations(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D, transportType: MKDirectionsTransportType) {
        let request = createDirectionsRequest(start: start, end: end, transportType: transportType)
        let diresctions = MKDirections(request: request)
        resetMap()
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
