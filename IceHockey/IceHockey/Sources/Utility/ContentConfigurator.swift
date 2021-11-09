//
//  ContentConfigurator.swift
//  IceHockey
//
//  Created by  Buxlan on 11/6/21.
//

import UIKit

protocol ConfigurableCollectionContent {
    static var reuseIdentifier: String { get }
    associatedtype DataType
    func configure(with data: DataType)
}
extension ConfigurableCollectionContent {
    static var reuseIdentifier: String { String(describing: Self.self) }
}

protocol ContentConfigurator {
    func configure(view: UIView)
}

final class CollectionViewConfigurator<ContentType: ConfigurableCollectionContent, DataType>: ContentConfigurator
where ContentType.DataType == DataType, ContentType: UIView {
    
    static var reuseIdentifier: String { return ContentType.reuseIdentifier }
        
    private let data: DataType
    
    init(data: DataType) {
        self.data = data
    }
    
    func configure(view: UIView) {
        if let view = view as? ContentType {
            view.configure(with: data)
        }
    }
}

typealias SettingViewConfigurator = CollectionViewConfigurator<SettingTableCell,
                                                               SettingCellModel>

typealias MatchResultEditViewConfigurator = CollectionViewConfigurator<MatchResultEditCell,
                                                                       MatchResultEditCellModel>

typealias MatchResultViewConfigurator = CollectionViewConfigurator<MatchResultTableCell,
                                                                   MatchResultTableCellModel>

typealias SaveViewConfigurator = CollectionViewConfigurator<MatchResultEditSaveCell,
                                                            SaveCellModel>

// MARK: - News cell configurator
typealias NewsViewConfigurator = CollectionViewConfigurator<NewsTableCell,
                                                            NewsTableCellModel>
