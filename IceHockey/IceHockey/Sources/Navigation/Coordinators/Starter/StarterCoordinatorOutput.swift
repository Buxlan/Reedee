//
//  StarterCoordinatorOutput.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 22.03.2022.
//

protocol StarterCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}
