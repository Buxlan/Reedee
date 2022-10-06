//
//  BaseCoordinator.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 18.03.2022.
//

import Foundation

class BaseCoordinator {
    
    var childCoordinators: [Coordinatable] = []
    
    func addDependency(_ coordinator: Coordinatable) {
        if childCoordinators.first(where: { $0 === coordinator }) != nil {
            return
        }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinatable?) {
        guard !childCoordinators.isEmpty,
              let coordinator = coordinator
        else { return }
        
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
    
}
