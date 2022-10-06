//
//  MainViewProtocol.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.03.2022.
//

protocol MainViewProtocol: BaseViewProtocol, MainCoordinatorDelegate {
    var onCompletion: CompletionBlock? { get set }
}
