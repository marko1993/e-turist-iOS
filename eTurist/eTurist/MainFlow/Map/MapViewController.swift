//
//  MapViewController.swift
//  eTurist
//
//  Created by Marko on 05.06.2021..
//

import UIKit
import MapKit
import CoreLocation
import RxSwift
import RxCocoa

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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeGeofenceRegions()
    }
    
    private func setupBindings() {
        
        self.setDelegate(for: mapView.destinationsCollectionsView)
        self.viewModel
            .destinationsObservable
            .observeOn(MainScheduler.instance)
            .bind(to: mapView.destinationsCollectionsView
                .rx
                .items) { cv, row, data in
                let cell = cv.dequeueReusableCell(withReuseIdentifier: DestinationCollectionsViewCell.cellIdentifier, for: IndexPath.init(row: row, section: 0)) as! DestinationCollectionsViewCell
                
                cell.setup(with: data, shouldIndicateVisitedState: true)
                return cell
            }.disposed(by: disposeBag)
        
        mapView.backButton.onTap(disposeBag: disposeBag) { [weak self] in
            self?.viewModel.exitMapViewController()
        }
        
        viewModel.destinationsObservable.subscribe { [weak self] destinations in
            self?.mapView.destinationsCollectionsView.reloadData()
        }.disposed(by: disposeBag)
        
        viewModel.visitedDestinationObservable.subscribe (onNext: { [weak self] destination in
            guard let _ = destination else { return }
            self?.connectNextUnvisitedDestination()
        }).disposed(by: disposeBag)
        
        mapView.arrowImage.onTap(disposeBag: disposeBag) { [weak self] in
            self?.mapView.animateDestinaitonsCollectionView()
        }
        
        mapView.travelModeSC.addTarget(self, action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        
        self.mapView.destinationsCollectionsView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            if let userLocation = self?.getUserLocation()?.coordinate {
                guard let destinationCoordinates = self?.viewModel.getUpdatedCurrentDestination(indexPath: indexPath)?.coordinates.coordinates else { return }
                self?.mapView.connectLocations(
                    start: userLocation,
                    end: CLLocationCoordinate2D(latitude: destinationCoordinates[0], longitude: destinationCoordinates[1]),
                    transportType: (self?.mapView.travelModeSC.selectedSegmentIndex == 0) ? .walking : .automobile)
            }
        }).disposed(by: disposeBag)
    }
    
    func setDelegate(for collectionView: UICollectionView) {
        collectionView.delegate = nil
        collectionView.dataSource = nil
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!) {
        if let userLocation = getUserLocation()?.coordinate {
            guard let destinationCoordinates = self.viewModel.currentDestination?.coordinates.coordinates else { return }
            mapView.connectLocations(
                start: userLocation,
                end: CLLocationCoordinate2D(latitude: destinationCoordinates[0], longitude: destinationCoordinates[1]),
                transportType: (sender.selectedSegmentIndex == 0) ? .walking : .automobile)
        }
    }
   
}

extension MapViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 2
        let spacing:CGFloat = 6.0
        
        let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        
        let width = (mapView.destinationsCollectionsView.bounds.width - totalSpacing)/numberOfItemsPerRow
        return CGSize(width: width - 10, height: 200)
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
        self.mapView.setupMapView()
        self.mapView.setupMarkers(items: self.viewModel.getDestinations())
        self.setupGeofencesForDestinations(destinations: self.viewModel.getDestinations())
        self.connectNextUnvisitedDestination()
        self.startUpdatingLocation()
    }
    
    func locationViewController(_ controller: LocationViewController, didReceive location: CLLocation?) {
        guard let location = location else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        guard let destinationCoordinates = self.viewModel.currentDestination?.coordinates.coordinates else {
            self.mapView.zoomInToLocation(location: center, radius: K.MapKeys.zoomRadius)
            return
        }
        self.mapView.connectLocations(
            start: center,
            end: CLLocationCoordinate2D(latitude: destinationCoordinates[0], longitude: destinationCoordinates[1]),
            transportType: (self.mapView.travelModeSC.selectedSegmentIndex == 0) ? .walking : .automobile)
    }
    
    func locationViewController(_ controller: LocationViewController, manager: CLLocationManager, didEnterRegion region: CLRegion) {
        guard let destination = self.viewModel.getDestinationById(Int(region.identifier) ?? -1) else { return }
        if !(destination.userVisited ?? false) && destination.id != 0 {
            self.viewModel.addDestinationToVisited(destination)
        }
    }
    
    private func setupGeofencesForDestinations(destinations: [Destination]?) {
        destinations?.forEach { [weak self] destination in
            let coordinate = CLLocationCoordinate2D(latitude: destination.coordinates.coordinates[0], longitude: destination.coordinates.coordinates[1])
            let geofenceRegion = CLCircularRegion(center: coordinate, radius: K.MapKeys.geofenceRadius, identifier: String(destination.id))
            self?.addGeofenceRegion(region: geofenceRegion)
        }
    }
    
    private func connectNextUnvisitedDestination() {
        if let userLocation = getUserLocation()?.coordinate {
            mapView.zoomInToLocation(location: userLocation, radius: K.MapKeys.zoomRadius)
            if let destinationCoordinates = viewModel.getNextUnvisitedDestination(userLocation: CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude))?.coordinates.coordinates {
                
                mapView.connectLocations(
                    start: userLocation,
                    end: CLLocationCoordinate2D(latitude: destinationCoordinates[0], longitude: destinationCoordinates[1]),
                    transportType: .walking)
            } else {
                self.mapView.showSuccessAnimation()
            }
        }
    }
    
}
