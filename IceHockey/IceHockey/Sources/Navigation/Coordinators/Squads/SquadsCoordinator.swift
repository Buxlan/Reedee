//
//  SquadsCoordinator.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 28.03.2022.
//

import UIKit

final class SquadsCoordinator: BaseCoordinator, SquadsCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    let router: Routable
    fileprivate let factory: SquadsFactoryProtocol
    
    init(router: Routable, factory: SquadsFactoryProtocol) {
        self.router = router
        self.factory = factory
    }
    
}

extension SquadsCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
}

// MARK: - Private methods
extension SquadsCoordinator {
    func performFlow() {
        let vc = factory.makeSquadsViewController()
        vc.onCompletion = finishFlow
        router.setRootModule(vc, hideBar: true)
    }
}
