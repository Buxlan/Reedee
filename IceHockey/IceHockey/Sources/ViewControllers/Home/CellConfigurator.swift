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

protocol Sizeable {
    var size: CGSize { get }
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

struct TableViewHeaderConfigurator<CellType: SizeableConfigurableCell,
                                   DataType>: Sizeable, CellConfigurator where DataType == CellType.DataType,
                                                                               CellType: UITableViewHeaderFooterView {
    
    static var reuseIdentifier: String { return CellType.reuseIdentifier }
    
    var size: CGSize {
        data.size
    }
    let data: DataType
    
    func configure(cell: UIView) {
        guard let cell = cell as? CellType else {
            Log(text: "Can't cast collection view cell to \(CellType.self)", object: self)
            return
        }
        cell.configure(with: data)
    }
}

// MARK: - Cells
typealias CommandTableCellConfigurator = TableViewCellConfigurator<ActionsTableCell,
                                                                   QuickAction>
//typealias NewsCellConfigurator = TableViewCellConfigurator<EventTableCell,
//                                                           SportEvent>
typealias ComingEventCellConfigurator = TableViewCellConfigurator<ComingEventTableCell,
                                                                  SportEvent>
typealias CommandCollectionCellConfigurator = CollectionViewCellConfigurator<ActionsCollectionCell,
                                                                             QuickAction>
typealias PhotoEventCollectionCellConfigurator = CollectionViewCellConfigurator<PhotoGalleryCollectionCell,
                                                                                SportEvent>
// MARK: - Headers
typealias NewsTableViewHeaderConfigurator = TableViewCellConfigurator<EventsSectionHeaderView,
                                                                      NewsTableViewCellHeaderConfiguration>
typealias ComingEventsHeaderConfigurator = TableViewCellConfigurator<ComingEventsSectionHeaderView,
                                                                     ComingEventsTableCellHeaderConfiguration>
