//
//  RoutesViewController.swift
//  eTurist
//
//  Created by Marko on 31.05.2021..
//

import UIKit

class RoutesViewController: BaseViewController {
    
    private let routesView = RoutesView()
    var viewModel: RoutesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(routesView)
    }
    
}
