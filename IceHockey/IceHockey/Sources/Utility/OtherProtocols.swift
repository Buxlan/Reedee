//
//  OtherProtocols.swift
//  IceHockey
//
//  Created by  Buxlan on 10/18/21.
//

import UIKit

protocol InputData {
    associatedtype DataType
    func setInputData(_ inputData: DataType)
}

protocol CellUpdatable: class {
    func configureCell(at indexPath: IndexPath, event: SportEvent) -> UITableViewCell
    func configureCell(at indexPath: IndexPath, configurator: CellConfigurator) -> UITableViewCell
    func reloadData()
}

protocol ViewControllerDismissable: class {
    func dismiss(animated: Bool)
}
