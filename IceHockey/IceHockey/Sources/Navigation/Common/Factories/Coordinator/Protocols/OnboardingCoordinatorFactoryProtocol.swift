//
//  OnboardingCoordinatorFactoryProtocol.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.10.2022.
//

protocol OnboardingCoordinatorFactoryProtocol {
    func makeOnboardingCoordinator(router: Routable)
    -> Coordinatable & OnboardingCoordinatorOutput
}
