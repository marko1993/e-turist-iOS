//
//  BaseViewModel.swift
//  eTurist
//
//  Created by Marko on 30.05.2021..
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {
    let disposeBag = DisposeBag()
    var coordinator: AppCoordinator?
    var repository: MainRepository?
    let errorRelay: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    
}

