//
//  RoutesViewController.swift
//  eTurist
//
//  Created by Marko on 31.05.2021..
//

import UIKit
import CoreLocation
import RxSwift
import RxCocoa

class RoutesViewController: LocationViewController {
    
    private let routesView = RoutesView()
    var viewModel: RoutesViewModel!
    var firstLoad = true
    
    override func viewDidLayoutSubviews() {
        if firstLoad {
            firstLoad = false
            viewModel
                .routesObservable
                .observeOn(MainScheduler.instance)
                .bind(to:
                        routesView.routesTableView
                        .rx
                        .items(
                            cellIdentifier: RoutesTableViewCell.cellIdentifier,
                            cellType: RoutesTableViewCell.self)) { index, data, cell in
                    
                    cell.setup(with: data, delegate: self)
                    cell.setupBindings(disposeBag: self.disposeBag)
            }.disposed(by: disposeBag)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(routesView)
        setupBinding()
        viewModel.getAllCities()
        locationViewControlleDelegate = self
        routesView.searchBar.delegate = self
        checkLocationServices()
    }
    
    private func setupBinding() {
        
       self.viewModel.errorRelay.asObservable().subscribe(onNext: { [weak self] error in
            if let error = error {
                self?.presentInfoDialog(message: error)
            }
        }).disposed(by: disposeBag)
        
        NotificationCenterService.receiveDataUpdates(observer: self, selector: #selector(dataDidChange))
        
    }
    
    @objc func dataDidChange(_ notification: Notification){
        self.viewModel.updateData()
    }
    
}

extension RoutesViewController: RoutesTableViewCellDelegate {
    func routesTableViewCell(_ cell: RoutesTableViewCell, didPressPlayButtonFor route: Route) {
        self.viewModel.presentMapScreen(route: route)
    }
    
    func routesTableViewCell(_ cell: RoutesTableViewCell, didSelectCellFor route: Route) {
        self.viewModel.presentRouteDetailsScreen(route: route)
    }
}

extension RoutesViewController: SearchBarDelegate {
    func searchBar(_ searchBar: SearchBar, didSelectCityPicker value: Bool) {
        if value {
            self.viewModel.presentCityPicker(delegate: self)
        }
    }
    
    func searchBar(_ searchBar: SearchBar, valueDidChange value: String?) {
        if let value = value {
            self.viewModel.filterRoutes(filter: value)
        }
    }
}

extension RoutesViewController: CityPickerDialogDelegate {
    func ChangePasswordDialog(_ dialog: CityPickerViewController, didSelectCity city: City) {
        self.viewModel.getRoutesForCity(city.identifier)
    }
}

extension RoutesViewController: LocationViewControllerDelegate {
    
    func locationViewController(_ controller: LocationViewController, manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
    }
    
    func locationViewController(_ controller: LocationViewController, didReceive location: CLLocation?) {
        
    }
    
    func locationViewController(_ controller: LocationViewController, didGetAuthorized: Bool?) {
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
    
}
