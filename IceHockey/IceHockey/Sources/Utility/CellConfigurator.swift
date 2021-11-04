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
    
    static func registerCell(tableView: UITableView) {
        tableView.register(CellType.self, forCellReuseIdentifier: CellType.reuseIdentifier)
    }
}

struct ActionableTableViewCellConfigurator<CellType: ConfigurableActionCell,
                                           DataType,
                                           HandlerType: CellActionHandler>: CellConfigurator where DataType == CellType.DataType,
                                                                                                   HandlerType == CellType.HandlerType,
                                                                                                   CellType: UIView {
    static var reuseIdentifier: String { return CellType.reuseIdentifier }
    
    let data: DataType
    let handler: HandlerType
    
    func configure(cell: UIView) {
        guard let cell = cell as? CellType else {
            Log(text: "Can't cast table view cell to \(CellType.self)", object: self)
            return
        }
        cell.configure(with: data, handler: handler)
    }
    
    static func registerCell(tableView: UITableView) {
        tableView.register(CellType.self, forCellReuseIdentifier: CellType.reuseIdentifier)
    }
}

struct ActionableCollectionViewCellConfigurator<CellType: ConfigurableActionCell,
                                                DataType,
                                                HandlerType: CellActionHandler>: CellConfigurator where DataType == CellType.DataType,
                                                                                                        HandlerType == CellType.HandlerType,
                                                                                                        CellType: UIView {
    static var reuseIdentifier: String { return CellType.reuseIdentifier }
    
    let data: DataType
    let handler: HandlerType
    
    func configure(cell: UIView) {
        guard let cell = cell as? CellType else {
            Log(text: "Can't cast collection view cell to \(CellType.self)", object: self)
            return
        }
        cell.configure(with: data, handler: handler)
    }
    
    static func registerCell(collectionView: UICollectionView) {
        collectionView.register(CellType.self, forCellWithReuseIdentifier: CellType.reuseIdentifier)
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

// MARK: - News cell configurator
typealias NewsCellConfigurator = TableViewCellConfigurator<EventTableCell,
                                                           NewsTableCellModel>

typealias MatchResultCellConfigurator = TableViewCellConfigurator<MatchResultTableCell,
                                                                  MatchResultTableCellModel>
// MARK: - MatchResult cell configurator

// MARK: - Event detail configurators
typealias EventPhotoCellConfigurator = TableViewCellConfigurator<EventDetailPhotoTableCell,
                                                                 [ImageDataConfiguration]>
typealias EventDetailPhotoCollectionCellConfigurator = CollectionViewCellConfigurator<EventDetailPhotoCollectionViewCell,
                                                                                      ImageDataConfiguration>
typealias EventDetailUsefulButtonsCellConfigurator = TableViewCellConfigurator<EventDetailUsefulButtonsCell,
                                                                               SportNews>
typealias EventDetailTitleCellConfigurator = TableViewCellConfigurator<EventDetailTitleCell,
                                                                       SportNews>
typealias EventDetailDescriptionCellConfigurator = TableViewCellConfigurator<EventDetailDescriptionCell,
                                                                             SportNews>
typealias EventDetailBoldTextCellConfigurator = TableViewCellConfigurator<EventDetailBoldViewCell,
                                                                          SportNews>
typealias EventDetailCopyrightCellConfigurator = TableViewCellConfigurator<EventDetailCopyrightCell,
                                                                           SportTeam>

// MARK: - Edit event configurators
typealias EditEventTitleCellConfigurator = ActionableTableViewCellConfigurator<EditEventTitleCell,
                                                                               String?,
                                                                               EditEventHandler>
typealias EditEventTitleTextFieldCellConfigurator = ActionableTableViewCellConfigurator<EditEventInputTitleCell,
                                                                                        String?,
                                                                                        EditEventHandler>
typealias EditEventTextCellConfigurator = ActionableTableViewCellConfigurator<EditEventInputTextCell,
                                                                              String?,
                                                                              EditEventHandler>
typealias EditEventBoldTextCellConfigurator = ActionableTableViewCellConfigurator<EditEventInputBoldTextCell,
                                                                                  String?,
                                                                                  EditEventHandler>
typealias EditEventAddPhotoCellConfigurator = ActionableTableViewCellConfigurator<EditEventPhotoCell,
                                                                                  [ImageDataConfiguration],
                                                                                  EditEventHandler>
typealias EditEventSaveCellConfigurator = ActionableTableViewCellConfigurator<EditEventSaveCell,
                                                                              String?,
                                                                              EditEventHandler>
typealias EditEventInputDateCellConfigurator = ActionableTableViewCellConfigurator<EditEventInputDateCell,
                                                                                   Date?,
                                                                                   EditEventHandler>

typealias EditEventAddPhotoCollectionCellConfigurator = ActionableCollectionViewCellConfigurator<EditEventAddPhotoCollectionCell,
                                                                                        UIImage?,
                                                                                        EditEventHandler>

typealias EditEventPhotoCollectionCellConfigurator = ActionableCollectionViewCellConfigurator<EditEventPhotoCollectionCell,
                                                                                              ImageDataConfiguration,
                                                                                              EditEventHandler>
// MARK: Teams

typealias TeamCellConfigurator = TableViewCellConfigurator<TeamTableCell,
                                                           SportTeam>
typealias TeamDetailInfoCellConfigurator = TableViewCellConfigurator<TeamInfoTableCell,
                                                                     SportTeam>
typealias MapCellConfigurator = TableViewCellConfigurator<MapTableCell,
                                                          SportTeam>

typealias OurSquadsTitleTextViewCellConfigurator = TableViewCellConfigurator<OurSquadsTitleTextViewCell,
                                                                             SportTeam>

// MARK: Squads

typealias SquadCellConfigurator = TableViewCellConfigurator<SquadTableCell,
                                                            SportSquad>

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
// MARK: - Headers

typealias NewsTableViewHeaderConfigurator = TableViewCellConfigurator<EventsSectionHeaderView,
                                                                      NewsTableViewCellHeaderConfiguration>
typealias ComingEventsHeaderConfigurator = TableViewCellConfigurator<ComingEventsSectionHeaderView,
                                                                     ComingEventsTableCellHeaderConfiguration>
