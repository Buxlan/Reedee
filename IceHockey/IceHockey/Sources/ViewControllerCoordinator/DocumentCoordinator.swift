//
//  DocumentCoordinator.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 15.03.2022.
//

import UIKit

class DocumentCoordinator: ViewControllerCoordinator {
    
    static let shared = DocumentCoordinator()
    
    var childCoordinators = [ViewControllerCoordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func goToDocumentEditing(document: Document) {
        let vc = EditOperationDocumentViewController()
        vc.document = document
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    func goToDocumentListFromDocumentEditing() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func start() {
//        let vc = MainTabBarViewController()
//        navigationController.pushViewController(vc, animated: false)
    }
}

