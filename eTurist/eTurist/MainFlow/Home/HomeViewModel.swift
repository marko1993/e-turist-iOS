//
//  HomeViewModel.swift
//  eTurist
//
//  Created by Marko on 30.05.2021..
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    
    func getTestRoute(identifier: String?) -> Observable<TestRouteResponse>? {
        return repository?.getTestRoute(identifier: identifier)
    }
    
}

