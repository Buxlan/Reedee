//
//  LastNewsViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 9/6/21.
//

import UIKit

protocol DatableObject {
    associatedtype DataType
    var data: DataType? { get set }
}

enum LastEventsSectionType {
    typealias DataType = SportTeam
    typealias CellConfiguratorCollection = [CellConfigurator]
    
    case actions
    case news
    case coming
    case photo
    
    func getData(team: DataType?) -> CellConfiguratorCollection {
        guard let team = team else {
            Log(text: "Team is nil", object: self)
            return [CellConfigurator]()
        }
        switch self {
        case .actions:
            return prepareActionsSectionData(team: team)
        case .news:
            return prepareNewsSectionData(team: team)
        case .coming:
            return prepareComingSectionData(team: team)
        case .photo:
            return preparePhotoSectionData(team: team)
        }
    }
    
    private func prepareActionsSectionData(team: DataType) -> CellConfiguratorCollection {
        let actions: [QuickAction] = [
            QuickAction(type: .joinClub),
            QuickAction(type: .showTrainingSchedule),
            QuickAction(type: .photoGallery),
            QuickAction(type: .contacts),
            QuickAction(type: .action2),
            QuickAction(type: .action3)
        ]
        return actions.map { (action) -> CommandCollectionCellConfigurator in
            CommandCollectionCellConfigurator(data: action)
        }
    }
    
    private func prepareNewsSectionData(team: DataType) -> CellConfiguratorCollection {
        var items = [CellConfigurator]()
        let configuration = NewsTableViewCellHeaderConfiguration()
        let header = NewsTableViewHeaderConfigurator(data: configuration)
        items.append(header)
        let events = SportEvent.getLastEvents(team: team, from: 0)
        let cells = events.map { (event) -> NewsCellConfigurator in
            NewsCellConfigurator(data: event)
        }
        items.append(contentsOf: cells)
        return items
    }
    
    private func prepareComingSectionData(team: DataType) -> CellConfiguratorCollection {
        var items = [CellConfigurator]()
        let configuration = ComingEventsTableCellHeaderConfiguration()
        let header = ComingEventsHeaderConfigurator(data: configuration)
        items.append(header)
        let events = SportEvent.getComingEvents(team: team, from: 0)
        let cells = events.map { (event) -> ComingEventCellConfigurator in
            ComingEventCellConfigurator(data: event)
        }
        items.append(contentsOf: cells)
        return items
    }
    
    private func preparePhotoSectionData(team: DataType) -> CellConfiguratorCollection {
        let events = SportEvent.photoEvents(team: team, from: 0)
        return events.map { (event) -> PhotoEventCollectionCellConfigurator in
            PhotoEventCollectionCellConfigurator(data: event)
        }
    }
}

struct LastEventsViewModel: DatableObject {
    typealias DataType = SportTeam
    typealias CellConfiguratorCollection = [CellConfigurator]
    typealias SectionType = LastEventsSectionType
        
    lazy var sections: [SectionType: CellConfiguratorCollection] = {
        var items: [SectionType: CellConfiguratorCollection] = [
            SectionType.actions: SectionType.actions.getData(team: self.data),
            SectionType.news: SectionType.news.getData(team: self.data),
            SectionType.coming: SectionType.coming.getData(team: self.data),
            SectionType.photo: SectionType.photo.getData(team: self.data)
        ]
        return items
    }()
    
    var data: DataType? {
        didSet {
            guard data != nil else {
                fatalError("Data cannot be nil")
            }
            updateItems()
        }
    }
    
    init(data: DataType) {
        self.data = data
        items = CellConfiguratorCollection()
        updateItems()
    }
    
    var items: CellConfiguratorCollection
    
    private mutating func updateItems(needUpdateData: Bool = false,
                                      type: SectionType? = nil) {
        
        let empty = [CellConfigurator]()        
        
        if needUpdateData {
            if let type = type {
                updateSection(type)
            } else {
                updateAllSections()
            }
        }
        
        var items = [CellConfigurator]()
        // 1) Commands section
        // Header is absent
        items.append(CommandTableCellConfigurator(data: QuickAction(type: .photoGallery)))
        // 2) News section
        items.append(contentsOf: sections[.news] ?? empty)
        // 3) Coming events section
        items.append(contentsOf: sections[.coming] ?? empty)
        // 3) Photo gallery
        items.append(contentsOf: sections[.photo] ?? empty)
        
        self.items = items
    }
    
    mutating func updateSection(_ type: SectionType) {
        sections[type] = type.getData(team: self.data)
    }
    
    mutating func updateAllSections() {
        for section in sections {
            sections[section.key] = section.key.getData(team: self.data)
        }
    }
}

extension LastEventsViewModel {
    
}
