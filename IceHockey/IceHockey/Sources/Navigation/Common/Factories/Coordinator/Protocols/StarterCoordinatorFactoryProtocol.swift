//
//  StarterCoordinatorFactoryProtocol.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.10.2022.
//

protocol StarterCoordinatorFactoryProtocol {
    func makeStarterCoordinator(router: Routable)
    -> Coordinatable & StarterCoordinatorOutput
}
