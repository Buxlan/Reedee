//
//  ProfileCoordinatorFactoryProtocol.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.10.2022.
//

protocol ProfileCoordinatorFactoryProtocol {
    func makeProfileCoordinator(router: Routable)
    -> Coordinatable & ProfileCoordinatorOutput
}
