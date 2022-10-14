//
//  BaseViewModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 14.10.2022.
//

import RxCocoa
import RxSwift

protocol BaseViewModel: AnyObject, DisposeBagContaining, StatusRelayContaining, UserInterfaceUpdatable, DataUpdatable {
    init()
}
