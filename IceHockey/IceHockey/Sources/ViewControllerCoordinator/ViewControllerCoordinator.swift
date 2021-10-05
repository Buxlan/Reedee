//
//  ViewControllerCoordinator.swift
//  IceHockey
//
//  Created by  Buxlan on 10/6/21.
//

import UIKit

protocol ViewControllerCoordinator {
    var childCoordinators: [ViewControllerCoordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
