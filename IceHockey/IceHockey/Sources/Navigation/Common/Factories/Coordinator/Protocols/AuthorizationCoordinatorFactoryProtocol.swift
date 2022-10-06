//
//  AuthorizationCoordinatorFactoryProtocol.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.10.2022.
//

protocol AuthorizationCoordinatorFactoryProtocol {
    func makeAuthorizationCoordinator(router: Routable)
    -> Coordinatable & AuthorizationCoordinatorOutput
}
