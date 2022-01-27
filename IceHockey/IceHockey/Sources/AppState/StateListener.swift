//
//  StateListener.swift
//  IceHockey
//
//  Created by Bushmakin Sergei / bushmakin@outlook.com on 22.01.2022.
//

import Foundation

public protocol StateListener {

    // invoked when state is modified
    func stateModified<T>(_ state: State<T>)

    var stateListenerQueue: DispatchQueue {get}
}

extension StateListener {
    public var stateListenerQueue: DispatchQueue {
        return DispatchQueue.main
    }
}
