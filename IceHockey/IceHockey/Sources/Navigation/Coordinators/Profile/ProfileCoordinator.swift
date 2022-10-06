//
//  ProfileCoordinator.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 28.03.2022.
//

import UIKit

final class ProfileCoordinator: BaseCoordinator, ProfileCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    let router: Routable
    fileprivate let factory: ProfileFactoryProtocol
    
    init(router: Routable, factory: ProfileFactoryProtocol) {
        self.router = router
        self.factory = factory
    }
    
}

extension ProfileCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
}

// MARK: - Private methods
extension ProfileCoordinator {
    func performFlow() {
        let vc = factory.makeProfileViewController()
        vc.onCompletion = finishFlow
        router.setRootModule(vc, hideBar: true)
    }
}
