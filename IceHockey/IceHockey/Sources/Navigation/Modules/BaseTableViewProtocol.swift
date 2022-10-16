//
//  BaseTableViewProtocol.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 16.10.2022.
//

protocol BaseTableViewProtocol: BaseViewProtocol {
    var onCompletion: CompletionBlock? { get set }
}
