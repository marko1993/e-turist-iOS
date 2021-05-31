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
        self.assembleRoutesViewController(container)
        self.assembleHistoryViewController(container)
        self.assembleProfileViewController(container)
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
            let controller = HomeViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            controller.viewModel = container.resolve(HomeViewModel.self, argument: coordinator)
            return controller
        }.inObjectScope(.transient)
    }
    
    private func assembleRoutesViewController(_ container: Container) {
        container.register(RoutesViewModel.self) { (resolver, coordinator: AppCoordinator) in
            let viewModel = RoutesViewModel()
            viewModel.coordinator = coordinator
            viewModel.repository = container.resolve(Repository.self, name: "main") as? MainRepository
            return viewModel
        }.inObjectScope(.transient)
        
        container.register(RoutesViewController.self) { (resolver, coordinator: AppCoordinator) in
            let controller = RoutesViewController()
            controller.viewModel = container.resolve(RoutesViewModel.self, argument: coordinator)
            return controller
        }.inObjectScope(.transient)
    }
    
    private func assembleHistoryViewController(_ container: Container) {
        container.register(HistoryViewModel.self) { (resolver, coordinator: AppCoordinator) in
            let viewModel = HistoryViewModel()
            viewModel.coordinator = coordinator
            viewModel.repository = container.resolve(Repository.self, name: "main") as? MainRepository
            return viewModel
        }.inObjectScope(.transient)
        
        container.register(HistoryViewController.self) { (resolver, coordinator: AppCoordinator) in
            let controller = HistoryViewController()
            controller.viewModel = container.resolve(HistoryViewModel.self, argument: coordinator)
            return controller
        }.inObjectScope(.transient)
    }
    
    private func assembleProfileViewController(_ container: Container) {
        container.register(ProfileViewModel.self) { (resolver, coordinator: AppCoordinator) in
            let viewModel = ProfileViewModel()
            viewModel.coordinator = coordinator
            viewModel.repository = container.resolve(Repository.self, name: "main") as? MainRepository
            return viewModel
        }.inObjectScope(.transient)
        
        container.register(ProfileViewController.self) { (resolver, coordinator: AppCoordinator) in
            let controller = ProfileViewController()
            controller.viewModel = container.resolve(ProfileViewModel.self, argument: coordinator)
            return controller
        }.inObjectScope(.transient)
    }
    
    
}
