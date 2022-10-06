//
//  SquadsCoordinatorOutput.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 28.03.2022.
//

protocol SquadsCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}
