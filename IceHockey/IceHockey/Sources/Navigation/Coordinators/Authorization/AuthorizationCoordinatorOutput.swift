//
//  AuthorizationCoordinatorOutput.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 18.03.2022.
//

protocol AuthorizationCoordinatorOutput: AnyObject {
    var finishFlow: CompletionBlock? { get set }
}
