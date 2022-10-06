//
//  ContactsCoordinatorFactoryProtocol.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.10.2022.
//

protocol ContactsCoordinatorFactoryProtocol {
    func makeContactsCoordinator(router: Routable)
    -> Coordinatable & ContactsCoordinatorOutput
}
