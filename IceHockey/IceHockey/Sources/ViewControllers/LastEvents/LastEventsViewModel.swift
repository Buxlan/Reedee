//
//  LastNewsViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 9/6/21.
//

import UIKit

struct LastEventsSection {
    var title: String?
    var icon: UIImage?
    var items: [CellConfigurator] = [CellConfigurator]()
}

protocol DatableObject {
    associatedtype DataType
    var data: DataType? { get set }
}

struct LastEventsViewModel: DatableObject {
    typealias DataType = SportTeam
    var data: DataType? 
    
    lazy var pinnedSection: LastEventsSection = {
        var items: [CellConfigurator]
        guard let data = data else {
            Log(text: "Team (data) is nil", object: self)
            items = [CellConfigurator]()            
            return LastEventsSection(title: L10n.News.tableViewPinnedSectionTitle,
                                     items: items)
        }
        let events = SportEvent.getLastPinnedEvents(team: data, from: 0)
        items = events.map { (event) -> PinnedEventCollectionCellConfigurator in
            PinnedEventCollectionCellConfigurator(data: event)
        }
        var section = LastEventsSection(title: L10n.News.tableViewPinnedSectionTitle,
                                        items: items)
        return section
    }()
    
    var sections: [LastEventsSection] {
        var sections = [LastEventsSection]()
        guard let team = data else {
            return sections
        }
        
        // Pinned events section
        var section = LastEventsSection(title: L10n.News.tableViewPinnedSectionTitle,
                                        items: [PinnedEventCellConfigurator(data: SportEvent.empty)])
        sections.append(section)
        
        // Last events section
        var events: [SportEvent]
        var items: [CellConfigurator]
        events = SportEvent.getLastEvents(team: team, from: 0)
        items = events.map { (event) -> EventCellConfigurator in
            EventCellConfigurator(data: event)
        }
        section = LastEventsSection(title: L10n.News.tableViewNewsSectionTitle,
                                                 items: items)
        sections.append(section)
        
        // Coming events section
        events = SportEvent.getComingEvents(team: team, from: 0)
        items = events.map { (event) -> ComingEventCellConfigurator in
            ComingEventCellConfigurator(data: event)
        }
        section = LastEventsSection(title: L10n.News.tableViewComingSectionTitle,
                                                 items: items)
        sections.append(section)
                       
        return sections
    }
    
    init(data: DataType? = nil) {
        self.data = data
    }
    
    func item(at index: IndexPath) -> CellConfigurator {
        return sections[index.section].items[index.row]
    }
}
