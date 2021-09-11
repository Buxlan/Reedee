//
//  TableCellActionsProxy.swift
//  IceHockey
//
//  Created by  Buxlan on 9/8/21.
//

import UIKit

enum CellAction {
    case didSelect
}

class CellActionProxy {
    
    private var actions = [String: (CellConfigurator, UIView) -> Void]()
    
    func invoke(action: CellAction, cell: UIView, config: CellConfigurator) {
        let key = "\(action.hashValue)\(type(of: config).reuseIdentifier)"
        if let action = self.actions[key] {
            action(config, cell)
        }
    }
    
    @discardableResult
    func on<CellType, DataType>(_ action: CellAction,
                                handler: @escaping ( (TableViewCellConfigurator<CellType,
                                                                                DataType>,
                                                      CellType) -> Void) ) -> Self {
        let key = "\(action.hashValue)\(CellType.reuseIdentifier)"
        self.actions[key] = { (config, cell) in
            if let config = config as? TableViewCellConfigurator<CellType, DataType>,
               let cell = cell as? CellType {
                handler(config, cell)
            }
        }
        return self
    }
    
    @discardableResult
    func on<CellType, DataType>(_ action: CellAction,
                                handler: @escaping ( (CollectionViewCellConfigurator<CellType,
                                                                                     DataType>,
                                                      CellType) -> Void) ) -> Self {
        let key = "\(action.hashValue)\(CellType.reuseIdentifier)"
        self.actions[key] = { (config, cell) in
            if let config = config as? CollectionViewCellConfigurator<CellType, DataType>,
               let cell = cell as? CellType {
                handler(config, cell)
            }
        }
        return self
    }
    
}
