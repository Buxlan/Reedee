//
//  CoordinatorFactory.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.03.2022.
//

final class CoordinatorFactory {
    fileprivate let modulesFactory = ModulesFactory()
}

extension CoordinatorFactory: CoordinatorFactoryProtocol {
    
    func makeStarterCoordinator(router: Routable) -> Coordinatable & StarterCoordinatorOutput {
        return StarterCoordinator(router: router, factory: modulesFactory)
    }
    
    func makeNewsCoordinator(router: Routable) -> Coordinatable & NewsCoordinatorOutput {
        return NewsCoordinator(router: router, factory: modulesFactory)
    }
    
    func makeProfileCoordinator(router: Routable) -> Coordinatable & ProfileCoordinatorOutput {
        return ProfileCoordinator(router: router, factory: modulesFactory)
    }
    
    func makeSquadsCoordinator(router: Routable) -> Coordinatable & SquadsCoordinatorOutput {
        return SquadsCoordinator(router: router, factory: modulesFactory)
    }
    
    func makeContactsCoordinator(router: Routable) -> ContactsCoordinatorOutput & Coordinatable {
        return ContactsCoordinator(router: router, factory: modulesFactory)
    }
    
    func makeAuthorizationCoordinator(router: Routable) -> AuthorizationCoordinatorOutput & Coordinatable {
        return AuthorizationCoordinator(router: router, factory: modulesFactory)
    }
    
    func makeMainCoordinator(router: Routable) -> Coordinatable & MainCoordinatorOutput {
        return MainCoordinator(router: router, factory: modulesFactory)
    }
    
    func makeOnboardingCoordinator(router: Routable) -> Coordinatable & OnboardingCoordinatorOutput {
        return OnboardingCoordinator(router: router, factory: modulesFactory)
    }
    
    func makeFinanceCoordinator(router: Routable) -> Coordinatable & FinanceCoordinatorOutput {
        return FinanceCoordinator(router: router, factory: modulesFactory)
    }
    
    func makeTrainingScheduleCoordinator(router: Routable) -> Coordinatable & TrainingScheduleCoordinatorOutput {
        return TrainingScheduleCoordinator(router: router, factory: modulesFactory)
    }
    
}
