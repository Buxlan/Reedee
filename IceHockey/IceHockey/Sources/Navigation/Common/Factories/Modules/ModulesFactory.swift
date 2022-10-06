//
//  ModulesFactory.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.03.2022.
//

final class ModulesFactory {}

// MARK: - AuthorizationFactoryProtocol
extension ModulesFactory: AuthorizationFactoryProtocol {
    func makeSignInViewController() -> SignInViewProtocol {
        let vc = SignInViewController()
        return vc
    }
}

// MARK: - MainFactoryProtocol
extension ModulesFactory: MainFactoryProtocol {
    func makeMainViewController() -> MainViewProtocol {
        let vc = MainTabBarViewController()
        return vc
    }
}

// MARK: - NewsFactoryProtocol
extension ModulesFactory: NewsFactoryProtocol {
    func makeNewsViewController() -> NewsViewProtocol {
        let vc = HomeViewController()
        return vc
    }    
}

// MARK: - OnboardingFactoryProtocol
extension ModulesFactory: OnboardingFactoryProtocol {
    func makeOnboardingViewController() -> OnboardingViewProtocol {
        let vc = OnboardingPageViewController()
        return vc
    }
}

// MARK: - StarterFactoryProtocol
extension ModulesFactory: StarterFactoryProtocol {
    func makeStartViewController() -> StarterViewProtocol {
        let vc = StarterViewController()
        return vc
    }
}

// MARK: - ProfileFactoryProtocol
extension ModulesFactory: ProfileFactoryProtocol {
    func makeProfileViewController() -> ProfileViewProtocol {
        let vc = ProfileViewController()
        return vc
    }
}

// MARK: - SquadsFactoryProtocol
extension ModulesFactory: SquadsFactoryProtocol {
    func makeSquadsViewController() -> SquadsViewProtocol {
        let vc = SquadDetailViewController()
        return vc
    }
}

// MARK: - FinanceFactoryProtocol
extension ModulesFactory: FinanceFactoryProtocol {
    func makeFinanceViewController() -> FinanceViewProtocol {
        let vc = FinanceRouterViewController()
        return vc
    }
}

// MARK: - ContactsFactoryProtocol
extension ModulesFactory: ContactsFactoryProtocol {
    func makeContactsViewController() -> ContactsViewProtocol {
        let vc = ContactsViewController()
        return vc
    }
}

// MARK: - TrainingScheduleFactoryProtocol
extension ModulesFactory: TrainingScheduleFactoryProtocol {    
    func makeTrainingScheduleViewController() -> TrainingScheduleViewProtocol {
        let vc = TrainingScheduleViewController()
        return vc
    }
}

