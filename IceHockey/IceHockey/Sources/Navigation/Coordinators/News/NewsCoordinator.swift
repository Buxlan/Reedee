//
//  NewsCoordinator.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 28.03.2022.
//

import UIKit

final class NewsCoordinator: BaseCoordinator, NewsCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    let router: Routable
    fileprivate let factory: NewsFactoryProtocol
    
    init(router: Routable, factory: NewsFactoryProtocol) {
        self.router = router
        self.factory = factory
    }
    
}

extension NewsCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
}

// MARK: - Private methods
extension NewsCoordinator {
    func performFlow() {
        let vc = factory.makeNewsViewController()
        vc.onCompletion = finishFlow
        router.setRootModule(vc, hideBar: true)
    }
}
