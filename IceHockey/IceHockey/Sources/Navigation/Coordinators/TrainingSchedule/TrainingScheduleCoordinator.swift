//
//  TrainingScheduleCoordinator.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 07.10.2022.
//

import UIKit

final class TrainingScheduleCoordinator: BaseCoordinator, TrainingScheduleCoordinatorOutput {
    
    var finishFlow: CompletionBlock?
    
    let router: Routable
    fileprivate let factory: TrainingScheduleFactoryProtocol
    
    init(router: Routable, factory: TrainingScheduleFactoryProtocol) {
        self.router = router
        self.factory = factory
    }
    
}

extension TrainingScheduleCoordinator: Coordinatable {
    func start() {
        performFlow()
    }
}

// MARK: - Private methods
extension TrainingScheduleCoordinator {
    func performFlow() {
        let vc = factory.makeTrainingScheduleViewController()
        vc.onCompletion = finishFlow
        router.setRootModule(vc, hideBar: true)
    }
}
