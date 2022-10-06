//
//  OnboardingCoordinatorOutput.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.03.2022.
//

protocol OnboardingCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}
