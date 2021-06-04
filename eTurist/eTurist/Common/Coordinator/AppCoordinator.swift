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
    let userSingleton: UserSingleton!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.userSingleton = Assembler.sharedAssembler.resolver.resolve(UserSingleton.self)
    }
    
    func start() {
        if userSingleton.isUserLoggedIn() {
            presentHomeScreen()
        } else {
            presentLoginScreen()
        }
    }
    
    func presentHomeScreen() {
        let viewController = Assembler.sharedAssembler.resolver.resolve(HomeViewController.self, argument: self)!
        viewController.tabBarItems = [
            TabBarItem(viewController: Assembler.sharedAssembler.resolver.resolve(RoutesViewController.self, argument: self)!, title: "Route", image: "route", position: 0, isSelected: true),
            TabBarItem(viewController: Assembler.sharedAssembler.resolver.resolve(HistoryViewController.self, argument: self)!, title: "History", image: "history", position: 1, isSelected: false),
            TabBarItem(viewController: Assembler.sharedAssembler.resolver.resolve(ProfileViewController.self, argument: self)!, title: "Profile", image: "profile", position: 2, isSelected: false)
        ]
        self.currentViewController = viewController
        self.navigationController.setViewControllers([currentViewController!], animated: true)
    }
    
    func presentLoginScreen(error: String? = nil) {
        let viewController = Assembler.sharedAssembler.resolver.resolve(LoginViewCotroller.self, argument: self)!
        self.currentViewController = viewController
        self.navigationController.setViewControllers([currentViewController!], animated: true)
        if let error = error {
            (currentViewController as? LoginViewCotroller)?.viewModel.errorRelay.accept(error)
        }
    }
    
    func presentRegistrationScreen() {
        let viewController = Assembler.sharedAssembler.resolver.resolve(RegistrationViewController.self, argument: self)!
        self.currentViewController = viewController
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentCodeValidationScreen(email: String, password: String) {
        let viewController = Assembler.sharedAssembler.resolver.resolve(CodeValidationViewController.self, arguments: self, email, password)!
        self.currentViewController = viewController
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}
