//
//  AppCoordinator.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.03.2022.
//

import UIKit

fileprivate enum LaunchInstructor {
    case onboarding,
         authorization,
         main,
         starter
    
    static func setup() -> LaunchInstructor {        
        switch (Session.isAppLoaded, Session.isSeenOnboarding, Session.isAuthorized) {
        case (false, _, _):
            return .starter
        case (_, false, false), (_, false, true):
            return .onboarding
//        case (_, true, false):
//            return .authorization
//        case (_, true, true):
//            return main
//        }
        default:
            return main
        }
        
    }
}

final class AppCoordinator: BaseCoordinator {
    
    fileprivate let factory: CoordinatorFactoryProtocol
    let router: Routable
    
    fileprivate var instructor: LaunchInstructor {
        return LaunchInstructor.setup()
    }
    
    init(router: Routable, factory: CoordinatorFactory) {
        self.router = router
        self.factory = factory
        
        super.init()
        
        AuthManager.shared.addObserver(self)
    }
    
}

// MARK: - Coordinatable
extension AppCoordinator: Coordinatable {
    func start() {
        print("AppCoordinator start")
        switch instructor {
        case .authorization:
            print("AppCoordinator auth")
            performAuthorization()
        case .main:
            print("AppCoordinator main")
            performMainFlow()
        case .onboarding:
            print("AppCoordinator onboarding")
            performOnboardingFlow()
        case .starter:
            print("AppCoordinator starter")
            performStarterFlow()
        }
        if let navController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            print("AppCoordinator navController \(navController), viewControllers: \(navController.viewControllers)")
        }
    }
}

// MARK: - Private methods
private extension AppCoordinator {
    
    func performAuthorization() {
        let coordinator = factory.makeAuthorizationCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            guard let self = self,
                  let coordinator = coordinator
            else {
                return
            }
            self.removeDependency(coordinator)
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func performMainFlow() {
        let coordinator = factory.makeMainCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            guard let self = self,
                  let coordinator = coordinator
            else {
                return
            }
            self.removeDependency(coordinator)
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func performOnboardingFlow() {
        let coordinator = factory.makeOnboardingCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            guard let self = self,
                  let coordinator = coordinator
            else {
                return
            }
            Session.isSeenOnboarding = true
            self.removeDependency(coordinator)
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    func performStarterFlow() {
        let coordinator = factory.makeStarterCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            guard let self = self,
                  let coordinator = coordinator
            else {
                return
            }
            Session.isAppLoaded = true
            self.removeDependency(coordinator)
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
}

extension AppCoordinator: AuthObserver {
    func didChangeUser(_ user: ApplicationUser) {
        start()
    }
}
