//
//  NewsCoordinatorFactoryProtocol.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.10.2022.
//

protocol NewsCoordinatorFactoryProtocol {
    func makeNewsCoordinator(router: Routable)
    -> Coordinatable & NewsCoordinatorOutput
}
