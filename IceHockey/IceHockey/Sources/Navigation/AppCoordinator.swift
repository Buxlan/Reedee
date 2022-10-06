//
//  AppCoordinator.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.03.2022.
//

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
    }
    
}

// MARK: - Coordinatable
extension AppCoordinator: Coordinatable {
    func start() {
        switch instructor {
        case .authorization:
            performAuthorization()
        case .main:
            performMainFlow()
        case .onboarding:
            performOnboardingFlow()
        case .starter:
            performStarterFlow()
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
