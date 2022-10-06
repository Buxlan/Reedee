//
//  SquadsCoordinatorFactoryProtocol.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.10.2022.
//

protocol SquadsCoordinatorFactoryProtocol {
    func makeSquadsCoordinator(router: Routable)
    -> Coordinatable & SquadsCoordinatorOutput
}
