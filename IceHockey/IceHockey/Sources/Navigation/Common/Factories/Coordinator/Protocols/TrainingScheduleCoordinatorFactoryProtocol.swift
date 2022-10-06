//
//  TrainingScheduleCoordinatorFactoryProtocol.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 07.10.2022.
//

protocol TrainingScheduleCoordinatorFactoryProtocol {
    func makeTrainingScheduleCoordinator(router: Routable)
    -> Coordinatable & TrainingScheduleCoordinatorOutput
}
