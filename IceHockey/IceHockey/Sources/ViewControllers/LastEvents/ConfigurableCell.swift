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

protocol SizeableConfigurableCell {
    static var reuseIdentifier: String { get }
    var isInterfaceConfigured: Bool { get set }
        
    associatedtype DataType where DataType: Sizeable
    func configure(with data: DataType)
}
extension SizeableConfigurableCell {
    static var reuseIdentifier: String { String(describing: Self.self) }
}

protocol ContainedCollectionViewCell {
    var delegate: UICollectionViewDelegate? { get set }
    var dataSource: UICollectionViewDataSource? { get set }
}
