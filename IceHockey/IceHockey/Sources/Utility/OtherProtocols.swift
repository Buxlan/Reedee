//
//  OtherProtocols.swift
//  IceHockey
//
//  Created by  Buxlan on 10/18/21.
//

import UIKit

protocol InputData {
    associatedtype InputDataType
    func setInputData(_ inputData: InputDataType)
}

protocol CellUpdatable: AnyObject {
    func configureCell(at indexPath: IndexPath) -> UITableViewCell
    func configureCell(at indexPath: IndexPath, event: SportEvent) -> UITableViewCell
    func configureCell(at indexPath: IndexPath, configurator: CellConfigurator) -> UITableViewCell
    func reloadData()
}

extension CellUpdatable {
    func configureCell(at indexPath: IndexPath, event: SportEvent) -> UITableViewCell {
        return UITableViewCell()
    }
    func configureCell(at indexPath: IndexPath, configurator: CellConfigurator) -> UITableViewCell {
        return UITableViewCell()
    }
    func configureCell(at indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    } 
    func reloadData() {
    }
}

protocol ViewControllerDismissable: AnyObject {
    func dismiss(animated: Bool)
}
