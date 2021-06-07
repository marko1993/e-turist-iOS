//
//  CityPickerViewModel.swift
//  eTurist
//
//  Created by Marko on 07.06.2021..
//

import Foundation
import RxCocoa

class CityPickerViewModel: BaseViewModel {
    
    var currentCity: City!
    var citiesRelay: BehaviorRelay<[City]> = BehaviorRelay(value: [])
    
    func getCityByIndexPath(_ indexPath: IndexPath) -> City {
        return citiesRelay.value[indexPath.row]
    }
    
}
