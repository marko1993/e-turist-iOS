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
        viewController.tabBarItems = [
            TabBarItem(viewController: Assembler.sharedAssembler.resolver.resolve(RoutesViewController.self, argument: self)!, title: "Route", image: "route", position: 0, isSelected: true),
            TabBarItem(viewController: Assembler.sharedAssembler.resolver.resolve(HistoryViewController.self, argument: self)!, title: "History", image: "history", position: 1, isSelected: false),
            TabBarItem(viewController: Assembler.sharedAssembler.resolver.resolve(ProfileViewController.self, argument: self)!, title: "Profile", image: "profile", position: 2, isSelected: false)
        ]
        self.currentViewController = viewController
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
}
