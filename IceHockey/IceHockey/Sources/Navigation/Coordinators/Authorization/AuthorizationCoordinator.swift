//
//  AuthorizationCoordinator.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 18.03.2022.
//

import UIKit

final class AuthorizationCoordinator: BaseCoordinator, AuthorizationCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    fileprivate let factory: AuthorizationFactoryProtocol
    let router: Routable
    
    init(router: Routable, factory: AuthorizationFactoryProtocol) {
        self.router = router
        self.factory = factory
    }
    
}

extension AuthorizationCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
}

extension AuthorizationCoordinator {
    func performFlow() {
        let vc = factory.makeSignInViewController()
        vc.onCompletion = finishFlow
        router.setRootModule(vc, hideBar: true)
    }
}
