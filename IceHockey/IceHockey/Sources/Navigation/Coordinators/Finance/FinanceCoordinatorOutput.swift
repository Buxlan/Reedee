//
//  FinanceCoordinatorOutput.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 28.03.2022.
//

protocol FinanceCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}
