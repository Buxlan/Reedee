//
//  CoordinatorFactoryProtocol.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 18.03.2022.
//

protocol CoordinatorFactoryProtocol: AuthorizationCoordinatorFactoryProtocol,
                                     OnboardingCoordinatorFactoryProtocol,
                                     MainCoordinatorFactoryProtocol,
                                     StarterCoordinatorFactoryProtocol,
                                     NewsCoordinatorFactoryProtocol,
                                     ProfileCoordinatorFactoryProtocol,
                                     SquadsCoordinatorFactoryProtocol,
                                     ContactsCoordinatorFactoryProtocol,
                                     FinanceCoordinatorFactoryProtocol,
                                     TrainingScheduleCoordinatorFactoryProtocol {
}
