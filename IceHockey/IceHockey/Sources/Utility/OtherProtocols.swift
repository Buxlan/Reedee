//
//  OtherProtocols.swift
//  IceHockey
//
//  Created by  Buxlan on 10/18/21.
//

import UIKit

protocol InputData {
    associatedtype DataType
    var inputData: DataType? { get set }
}

protocol CellUpdatable: class {
    func configureCell(at indexPath: IndexPath, event: SportEvent) -> UITableViewCell
    func configureCell(at indexPath: IndexPath, configurator: CellConfigurator) -> UITableViewCell
    func reloadData()
}
