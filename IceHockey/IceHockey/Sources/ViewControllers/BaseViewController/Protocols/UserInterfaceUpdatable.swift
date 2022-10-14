//
//  UserInterfaceUpdatable.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 14.10.2022.
//

import Foundation

protocol UserInterfaceUpdatable {    
    var uiRefreshHandler: () -> Void { get set }
    
    init()
    
    func updateInterface()
}

extension UserInterfaceUpdatable {
    func updateInterface() {
        RunLoop.main.perform(inModes: [.common]) {
            self.uiRefreshHandler()
        }
    }
}
