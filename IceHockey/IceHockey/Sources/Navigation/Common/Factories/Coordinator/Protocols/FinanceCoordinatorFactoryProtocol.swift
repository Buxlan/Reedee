//
//  FinanceCoordinatorFactoryProtocol.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 06.10.2022.
//

protocol FinanceCoordinatorFactoryProtocol {
    func makeFinanceCoordinator(router: Routable)
    -> Coordinatable & FinanceCoordinatorOutput
}
