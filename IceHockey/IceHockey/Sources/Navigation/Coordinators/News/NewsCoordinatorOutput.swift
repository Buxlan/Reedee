//
//  NewsCoordinatorOutput.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 28.03.2022.
//

protocol NewsCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}
