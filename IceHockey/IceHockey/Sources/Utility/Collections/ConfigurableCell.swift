//
//  ConfigurableCell.swift
//  IceHockey
//
//  Created by  Buxlan on 9/13/21.
//

import UIKit

protocol ConfigurableCell {
    static var reuseIdentifier: String { get }
    var isInterfaceConfigured: Bool { get set }
        
    associatedtype DataType
    func configure(with data: DataType)
}
extension ConfigurableCell {
    static var reuseIdentifier: String { String(describing: Self.self) }
}

protocol ConfigurableActionCell {
    static var reuseIdentifier: String { get }    
    var isInterfaceConfigured: Bool { get set }
        
    associatedtype DataType
    associatedtype HandlerType
    func configure(with data: DataType, handler: HandlerType)
}
extension ConfigurableActionCell {
    static var reuseIdentifier: String { String(describing: Self.self) }
}
