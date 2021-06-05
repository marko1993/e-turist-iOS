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
    
}
