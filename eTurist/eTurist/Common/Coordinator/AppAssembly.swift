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
        self.assembleLoginViewController(container)
        self.assembleRegistrationViewController(container)
        self.assembleCodeValidationViewController(container)
        self.assembleChangePasswordViewController(container)
        self.assembleMapViewController(container)
        self.assembleCityPickerViewController(container)
        self.assembleDestinationDetailsViewController(container)
        self.assembleCommentsViewController(container)
        self.assembleRouteDetailsViewController(container)
    }
    
    private func assembleRepository(_ container: Container) {
        container.register(UserSingleton.self) { r in
            return UserSingleton()
        }.inObjectScope(.container)
        
        container.register(NetworkService.self) { r in
            return NetworkService()
        }.inObjectScope(.container)
        
        container.register(Repository.self, name: "main") { r in
            let repository = MainRepository()
            repository.userSingleton = container.resolve(UserSingleton.self)
            repository.networkService = container.resolve(NetworkService.self)
            return repository
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
    
    private func assembleLoginViewController(_ container: Container) {
        container.register(LoginViewModel.self) { (resolver, coordinator: AppCoordinator) in
            let viewModel = LoginViewModel()
            viewModel.coordinator = coordinator
            viewModel.repository = container.resolve(Repository.self, name: "main") as? MainRepository
            return viewModel
        }.inObjectScope(.transient)
        
        container.register(LoginViewCotroller.self) { (resolver, coordinator: AppCoordinator) in
            let controller = LoginViewCotroller()
            controller.viewModel = container.resolve(LoginViewModel.self, argument: coordinator)
            return controller
        }.inObjectScope(.transient)
    }
    
    private func assembleRegistrationViewController(_ container: Container) {
        container.register(RegistrationViewModel.self) { (resolver, coordinator: AppCoordinator) in
            let viewModel = RegistrationViewModel()
            viewModel.coordinator = coordinator
            viewModel.repository = container.resolve(Repository.self, name: "main") as? MainRepository
            return viewModel
        }.inObjectScope(.transient)
        
        container.register(RegistrationViewController.self) { (resolver, coordinator: AppCoordinator) in
            let controller = RegistrationViewController()
            controller.viewModel = container.resolve(RegistrationViewModel.self, argument: coordinator)
            return controller
        }.inObjectScope(.transient)
    }
    
    private func assembleCodeValidationViewController(_ container: Container) {
        container.register(CodeValidationViewModel.self) { (resolver, coordinator: AppCoordinator, email: String, password: String) in
            let viewModel = CodeValidationViewModel(email: email, password: password)
            viewModel.coordinator = coordinator
            viewModel.repository = container.resolve(Repository.self, name: "main") as? MainRepository
            return viewModel
        }.inObjectScope(.transient)
        
        container.register(CodeValidationViewController.self) { (resolver, coordinator: AppCoordinator, email: String, password: String) in
            let controller = CodeValidationViewController()
            controller.viewModel = container.resolve(CodeValidationViewModel.self, arguments: coordinator, email, password)
            return controller
        }.inObjectScope(.transient)
    }
    
    private func assembleChangePasswordViewController(_ container: Container) {
        container.register(ChangePasswordViewModel.self) { (resolver, coordinator: AppCoordinator) in
            let viewModel = ChangePasswordViewModel()
            viewModel.coordinator = coordinator
            viewModel.repository = container.resolve(Repository.self, name: "main") as? MainRepository
            return viewModel
        }.inObjectScope(.transient)
        
        container.register(ChangePasswordViewController.self) { (resolver, coordinator: AppCoordinator, delegate: ChangePasswordDialogDelegate) in
            let controller = ChangePasswordViewController()
            controller.delegate = delegate
            controller.viewModel = container.resolve(ChangePasswordViewModel.self, argument: coordinator)
            return controller
        }.inObjectScope(.transient)
    }
    
    private func assembleMapViewController(_ container: Container) {
        container.register(MapViewModel.self) { (resolver, coordinator: AppCoordinator) in
            let viewModel = MapViewModel()
            viewModel.coordinator = coordinator
            viewModel.repository = container.resolve(Repository.self, name: "main") as? MainRepository
            return viewModel
        }.inObjectScope(.transient)
        
        container.register(MapViewController.self) { (resolver, coordinator: AppCoordinator, route: Route) in
            let controller = MapViewController()
            controller.viewModel = container.resolve(MapViewModel.self, argument: coordinator)
            controller.viewModel.route = route
            return controller
        }.inObjectScope(.transient)
    }
    
    private func assembleCityPickerViewController(_ container: Container) {
        container.register(CityPickerViewModel.self) { (resolver, coordinator: AppCoordinator, currentCity: City?, cities: [City]) in
            let viewModel = CityPickerViewModel()
            viewModel.currentCity = currentCity
            viewModel.citiesRelay.accept(cities)
            viewModel.coordinator = coordinator
            viewModel.repository = container.resolve(Repository.self, name: "main") as? MainRepository
            return viewModel
        }.inObjectScope(.transient)
        
        container.register(CityPickerViewController.self) { (resolver, coordinator: AppCoordinator, currentCity: City?, cities: [City], delegate: CityPickerDialogDelegate) in
            let controller = CityPickerViewController()
            controller.delegate = delegate
            controller.viewModel = container.resolve(CityPickerViewModel.self, arguments: coordinator, currentCity, cities)
            return controller
        }.inObjectScope(.transient)
    }
    
    private func assembleDestinationDetailsViewController(_ container: Container) {
        container.register(DestinationDetailsViewModel.self) { (resolver, coordinator: AppCoordinator) in
            let viewModel = DestinationDetailsViewModel()
            viewModel.coordinator = coordinator
            viewModel.repository = container.resolve(Repository.self, name: "main") as? MainRepository
            return viewModel
        }.inObjectScope(.transient)
        
        container.register(DestinationDetailsViewController.self) { (resolver, coordinator: AppCoordinator, destination: Destination) in
            let controller = DestinationDetailsViewController()
            controller.viewModel = container.resolve(DestinationDetailsViewModel.self, argument: coordinator)
            controller.viewModel.destination = destination
            return controller
        }.inObjectScope(.transient)
    }
    
    private func assembleRouteDetailsViewController(_ container: Container) {
        container.register(RouteDetailsViewModel.self) { (resolver, coordinator: AppCoordinator) in
            let viewModel = RouteDetailsViewModel()
            viewModel.coordinator = coordinator
            viewModel.repository = container.resolve(Repository.self, name: "main") as? MainRepository
            return viewModel
        }.inObjectScope(.transient)
        
        container.register(RouteDetailsViewController.self) { (resolver, coordinator: AppCoordinator, route: Route) in
            let controller = RouteDetailsViewController()
            controller.viewModel = container.resolve(RouteDetailsViewModel.self, argument: coordinator)
            controller.viewModel.route = route
            return controller
        }.inObjectScope(.transient)
    }
    
    private func assembleCommentsViewController(_ container: Container) {
        container.register(CommentsViewModel.self) { (resolver, coordinator: AppCoordinator) in
            let viewModel = CommentsViewModel()
            viewModel.coordinator = coordinator
            viewModel.repository = container.resolve(Repository.self, name: "main") as? MainRepository
            return viewModel
        }.inObjectScope(.transient)
        
        container.register(CommentsViewController.self) { (resolver, coordinator: AppCoordinator, destinationId: Int?, routeId: Int ) in
            let controller = CommentsViewController()
            controller.viewModel = container.resolve(CommentsViewModel.self, argument: coordinator)
            controller.viewModel.destinationId = destinationId
            controller.viewModel.routeId = routeId
            return controller
        }.inObjectScope(.transient)
    }
    
}
