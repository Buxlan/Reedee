//
//  MainCoordinatorFactoryProtocol.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.10.2022.
//

protocol MainCoordinatorFactoryProtocol {
    func makeMainCoordinator(router: Routable)
    -> Coordinatable & MainCoordinatorOutput
}
