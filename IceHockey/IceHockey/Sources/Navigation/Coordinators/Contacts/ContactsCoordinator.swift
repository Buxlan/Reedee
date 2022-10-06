//
//  ContactsCoordinator.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 28.03.2022.
//

import UIKit

final class ContactsCoordinator: BaseCoordinator, ContactsCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    let router: Routable
    fileprivate let factory: ContactsFactoryProtocol
    
    init(router: Routable, factory: ContactsFactoryProtocol) {
        self.router = router
        self.factory = factory
    }
    
}

extension ContactsCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
}

// MARK: - Private methods
extension ContactsCoordinator {
    func performFlow() {
        let vc = factory.makeContactsViewController()
        vc.onCompletion = finishFlow
        router.setRootModule(vc, hideBar: true)
    }
}
