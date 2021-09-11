//
//  TableViewCellConfigurator.swift
//  IceHockey
//
//  Created by  Buxlan on 9/8/21.
//

import UIKit

protocol CellConfigurator {
    static var reuseIdentifier: String { get }    
    func configure(cell: UIView)
}

struct TableViewCellConfigurator<CellType: ConfigurableCell,
                                 DataType>: CellConfigurator where DataType == CellType.DataType,
                                                                   CellType: UIView {
    static var reuseIdentifier: String { return CellType.reuseIdentifier }
    
    let data: DataType
    
    func configure(cell: UIView) {
        guard let cell = cell as? CellType else {
            Log(text: "Can't cast table view cell to \(CellType.self)", object: self)
            return
        }
        cell.configure(with: data)
    }
}

struct CollectionViewCellConfigurator<CellType: ConfigurableCell,
                                      DataType>: CellConfigurator where DataType == CellType.DataType,
                                                                        CellType: UIView {
    static var reuseIdentifier: String { return CellType.reuseIdentifier }
    
    let data: DataType
    
    func configure(cell: UIView) {
        guard let cell = cell as? CellType else {
            Log(text: "Can't cast collection view cell to \(CellType.self)", object: self)
            return
        }
        cell.configure(with: data)
    }
}

typealias PinnedEventCellConfigurator = TableViewCellConfigurator<PinnedEventTableCell, SportEvent>
typealias EventCellConfigurator = TableViewCellConfigurator<EventTableCell, SportEvent>
typealias ComingEventCellConfigurator = TableViewCellConfigurator<ComingEventTableCell, SportEvent>
typealias PinnedEventCollectionCellConfigurator = CollectionViewCellConfigurator<PinnedEventCollectionCell, SportEvent>
