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
    let arrowImage = UIImageView(image: UIImage(named: "downArrow")?.withRenderingMode(.alwaysTemplate))
    lazy var destinationsCollectionsView: UICollectionView = {
        let frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        return cv
    }()
    
    private var shouldAnimateDestinationsDown: Bool = true
    
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
        addSubview(arrowImage)
        addSubview(destinationsCollectionsView)
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
        
        arrowImage.tintColor = UIColor(named: K.Color.main)
        
        destinationsCollectionsView.delaysContentTouches = false
        destinationsCollectionsView.translatesAutoresizingMaskIntoConstraints = false
        destinationsCollectionsView.isScrollEnabled = true
        destinationsCollectionsView.showsVerticalScrollIndicator = false
        destinationsCollectionsView.showsHorizontalScrollIndicator = false
        destinationsCollectionsView.backgroundColor = .clear
        destinationsCollectionsView.isPagingEnabled = true
        destinationsCollectionsView.backgroundView?.backgroundColor = .clear
        destinationsCollectionsView.register(DestinationCollectionsViewCell.self, forCellWithReuseIdentifier: DestinationCollectionsViewCell.cellIdentifier)
        
    }
    
    func positionSubviews() {
        mapView.fillSuperview()
        
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0))
        backButton.constrainWidth(30)
        backButton.constrainHeight(30)
        
        travelModeSC.anchor(top: safeAreaLayoutGuide.topAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        travelModeSC.centerX(inView: self)
        
        arrowImage.anchor(bottom: destinationsCollectionsView.topAnchor)
        arrowImage.centerX(inView: self)
        arrowImage.constrainHeight(50)
        arrowImage.constrainWidth(50)
        
        destinationsCollectionsView.anchor(leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        
        destinationsCollectionsView.constrainHeight(220)
        
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
    
    func animateDestinaitonsCollectionView() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear) { [weak self] in
            if ((self?.shouldAnimateDestinationsDown) != nil) {
                self?.destinationsCollectionsView.center.y += (self?.destinationsCollectionsView.bounds.height)!
                self?.arrowImage.center.y += (self?.destinationsCollectionsView.bounds.height)!
                self?.arrowImage.transform = CGAffineTransform(rotationAngle: .pi)
            } else {
                self?.destinationsCollectionsView.center.y -= (self?.destinationsCollectionsView.bounds.height)!
                self?.arrowImage.center.y -= (self?.destinationsCollectionsView.bounds.height)!
                self?.arrowImage.transform = CGAffineTransform(rotationAngle: 0)
            }
            self?.layoutIfNeeded()
        } completion: { [weak self] isCompleted in
            self?.shouldAnimateDestinationsDown = !(self?.shouldAnimateDestinationsDown ?? true)
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
