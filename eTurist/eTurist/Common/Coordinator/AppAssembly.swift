//
//  AppAssembly.swift
//  eTurist
//
//  Created by Marko on 30.05.2021..
//

import Foundation
import Swinject

final class AppAssembly: Assembly {
    
    func assemble(container: Container) {
        self.assembleRepository(container)
        self.assembleHomeViewController(container)
    }
    
    private func assembleRepository(_ container: Container) {
        container.register(Repository.self, name: "main") { r in
            return MainRepository()
        }.inObjectScope(.container)
    }
    
    private func assembleHomeViewController(_ container: Container) {
        container.register(HomeViewModel.self) { (resolver, coordinator: AppCoordinator) in
            let viewModel = HomeViewModel()
            viewModel.coordinator = coordinator
            viewModel.repository = container.resolve(Repository.self, name: "main") as? MainRepository
            return viewModel
        }.inObjectScope(.transient)
        
        container.register(HomeViewController.self) { (resolver, coordinator: AppCoordinator) in
            let controller = HomeViewController()
            controller.viewModel = container.resolve(HomeViewModel.self, argument: coordinator)
            return controller
        }.inObjectScope(.transient)
    }
    
}
