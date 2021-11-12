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

typealias SquadHeaderViewConfigurator = CollectionViewConfigurator<SquadHeaderView,
                                                             SquadHeaderCellModel>

typealias TrainingViewConfigurator = CollectionViewConfigurator<TrainingCell,
                                                                TrainingCellModel>

// MARK: - Event detail configurators
typealias EventDetailHeaderViewConfigurator = CollectionViewConfigurator<EventDetailHeaderView,
                                                                         EventDetailHeaderCellModel>

typealias EventDetailUserViewConfigurator = CollectionViewConfigurator<EventDetailUserView,
                                                                       EventDetailUserCellModel>

typealias EventDetailPhotoViewConfigurator = CollectionViewConfigurator<EventDetailPhotoView,
                                                                        [EventDetailPhotoCellModel]>
typealias EventDetailPhotoCollectionCellConfigurator = CollectionViewConfigurator<EventDetailPhotoCollectionViewCell,
                                                                                      EventDetailPhotoCellModel>
typealias EventDetailUsefulButtonsViewConfigurator = CollectionViewConfigurator<EventDetailUsefulButtonsView,
                                                                                EventDetailUsefulButtonsCellModel>
typealias EventDetailTitleViewConfigurator = CollectionViewConfigurator<EventDetailTitleView,
                                                                        EventDetailTitleCellModel>
typealias EventDetailDescriptionViewConfigurator = CollectionViewConfigurator<EventDetailDescriptionView,
                                                                              EventDetailDescriptionCellModel>
typealias EventDetailBoldTextViewConfigurator = CollectionViewConfigurator<EventDetailBoldTextView,
                                                                           EventDetailBoldTextCellModel>
typealias EventDetailCopyrightViewConfigurator = CollectionViewConfigurator<EventDetailCopyrightView,
                                                                            EventDetailCopyrightCellModel>
