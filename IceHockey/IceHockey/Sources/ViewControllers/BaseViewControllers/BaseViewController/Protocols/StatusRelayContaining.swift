//
//  StatusRelayContaining.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 14.10.2022.
//

import RxCocoa

protocol StatusRelayContaining {
    
    var statusRelay: BehaviorRelay<Status?> { get }
    
}
