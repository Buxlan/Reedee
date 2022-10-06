//
//  FinanceCoordinator.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 28.03.2022.
//

import UIKit

final class FinanceCoordinator: BaseCoordinator, FinanceCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    let router: Routable
    fileprivate let factory: FinanceFactoryProtocol
    
    init(router: Routable, factory: FinanceFactoryProtocol) {
        self.router = router
        self.factory = factory
    }
    
}

extension FinanceCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
}

// MARK: - Private methods
extension FinanceCoordinator {
    func performFlow() {
        let vc = factory.makeFinanceViewController()
        vc.onCompletion = finishFlow
        router.setRootModule(vc, hideBar: true)
    }
}
