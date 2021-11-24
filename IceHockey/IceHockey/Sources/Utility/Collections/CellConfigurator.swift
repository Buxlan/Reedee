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
    static func registerCell(tableView: UITableView)
    static func registerCell(collectionView: UICollectionView)
}

extension CellConfigurator {
    static func registerCell(tableView: UITableView) {
    }
    static func registerCell(collectionView: UICollectionView) {
    }
}

struct OldTableRow<DataType> {
    var config: CellConfigurator
    var data: DataType
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
    
    static func registerCell(tableView: UITableView) {
        tableView.register(CellType.self, forCellReuseIdentifier: CellType.reuseIdentifier)
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
    
    static func registerCell(collectionView: UICollectionView) {
        collectionView.register(CellType.self, forCellWithReuseIdentifier: CellType.reuseIdentifier)
    }
}

// MARK: Teams

typealias TeamCellConfigurator = TableViewCellConfigurator<TeamTableCell,
                                                           Club>
typealias TeamDetailInfoCellConfigurator = TableViewCellConfigurator<TeamInfoTableCell,
                                                                     Club>
typealias MapCellConfigurator = TableViewCellConfigurator<MapTableCell,
                                                          Club>

typealias OurSquadsTitleTextViewCellConfigurator = TableViewCellConfigurator<OurSquadsTitleTextViewCell,
                                                                             Club>

// MARK: Squads

typealias SquadCellConfigurator = TableViewCellConfigurator<SquadTableCell,
                                                            Squad>

// MARK: Players

typealias PlayerCellConfigurator = TableViewCellConfigurator<PlayerTableCell,
                                                             SportPlayer>

// MARK: - Actions

typealias ActionCellConfigurator = TableViewCellConfigurator<ActionsTableCell,
                                                             QuickAction>

typealias ActionCollectionCellConfigurator = CollectionViewCellConfigurator<ActionsCollectionCell,
                                                                             QuickAction>
// MARK: - Not using

typealias ComingEventCellConfigurator = TableViewCellConfigurator<ComingEventTableCell,
                                                                  SportNews>
typealias PhotoEventCollectionCellConfigurator = CollectionViewCellConfigurator<PhotoGalleryCollectionCell,
                                                                                SportNews>
