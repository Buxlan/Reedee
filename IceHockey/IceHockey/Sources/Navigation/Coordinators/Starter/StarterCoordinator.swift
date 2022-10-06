//
//  StarterCoordinator.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 22.03.2022.
//

import UIKit

final class StarterCoordinator: BaseCoordinator, StarterCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    let router: Routable
    fileprivate let factory: StarterFactoryProtocol
    
    init(router: Routable, factory: StarterFactoryProtocol) {
        self.router = router
        self.factory = factory
    }
    
}

extension StarterCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
}

// MARK: - Private methods
extension StarterCoordinator {
    func performFlow() {
        let vc = factory.makeStartViewController()
        vc.onCompletion = finishFlow
        router.setRootModule(vc, hideBar: true)
    }
}
