//
//  CityPickerViewController.swift
//  eTurist
//
//  Created by Marko on 07.06.2021..
//

import UIKit
import RxSwift
import RxCocoa

class CityPickerViewController: BaseViewController, UIScrollViewDelegate {
    
    private let cityPickerView = CityPickerView()
    var viewModel: CityPickerViewModel!
    var delegate: CityPickerDialogDelegate!
    
    override func viewDidLayoutSubviews() {
        self.cityPickerView.citiesTableView.delegate = nil
        self.cityPickerView.citiesTableView.dataSource = nil
        self.viewModel?
            .citiesRelay
            .observeOn(MainScheduler.instance)
            .bind(to:
                    cityPickerView.citiesTableView
                    .rx
                    .items(
                        cellIdentifier: CityPickerTableViewCell.cellIdentifier,
                        cellType: CityPickerTableViewCell.self)) { index, data, cell in
                
                cell.setup(with: data, currentCityId: self.viewModel.currentCity.id)
        }.disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(cityPickerView)
        setupBindings()
    }
    
    func setupBindings() {
        cityPickerView.backgroundView.onTap(disposeBag: disposeBag) { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
        
        cityPickerView.citiesTableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            if let city = self?.viewModel.getCityByIndexPath(indexPath), let self = self {
                self.delegate.ChangePasswordDialog(self, didSelectCity: city)
                self.dismiss(animated: false, completion: nil)
            }
        }).disposed(by: disposeBag)
    }
    
}
