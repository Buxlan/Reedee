//
//  MainCoordinator.swift
//  IceHockey
//
//  Created by  Buxlan on 10/6/21.
//

import UIKit

class MainViewControllerCoordinator: ViewControllerCoordinator {
    var childCoordinators = [ViewControllerCoordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainTabBarViewController()
        navigationController.pushViewController(vc, animated: false)
    }
}
