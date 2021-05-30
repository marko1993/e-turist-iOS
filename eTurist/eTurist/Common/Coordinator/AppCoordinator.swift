//
//  AppCoordinator.swift
//  eTurist
//
//  Created by Marko on 30.05.2021..
//

import Foundation
import UIKit
import RxSwift
import Swinject

class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var currentViewController: UIViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = Assembler.sharedAssembler.resolver.resolve(HomeViewController.self, argument: self)!
        self.currentViewController = viewController
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
}
