//
//  OnboardingCoordinator.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.03.2022.
//

import UIKit

final class OnboardingCoordinator: BaseCoordinator, OnboardingCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    fileprivate let factory: OnboardingFactoryProtocol
    let router: Routable
    
    init(router: Routable, factory: OnboardingFactoryProtocol) {
        self.router = router
        self.factory = factory
    }
    
}

// MARK: - Coordinatable

extension OnboardingCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
}

// MARK: - Private methods
extension OnboardingCoordinator {
    private func performFlow() {
        let vc = factory.makeOnboardingViewController()
        vc.onCompletion = finishFlow
        router.setRootModule(vc, hideBar: true)
    }
}


