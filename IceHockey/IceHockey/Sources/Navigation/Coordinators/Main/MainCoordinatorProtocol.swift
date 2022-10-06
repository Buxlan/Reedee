//
//  MainCoordinatorProtocol.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 05.10.2022.
//

protocol MainCoordinatorProtocol: BaseCoordinator {
    
    func switchToTab(_ tab: ApplicationTab, animated: Bool)
    
    func execute(command: CoordinatorCommand, at tab: ApplicationTab, animated: Bool)
    
}
