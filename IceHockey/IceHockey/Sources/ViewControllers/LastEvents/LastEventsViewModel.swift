//
//  LastNewsViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 9/6/21.
//

import UIKit

struct LastEventsSection {
    var header: CellConfigurator
    var items: [CellConfigurator] = [CellConfigurator]()
}

protocol DatableObject {
    associatedtype DataType
    var data: DataType? { get set }
}

struct LastEventsViewModel: DatableObject {
    typealias DataType = SportTeam
    var data: DataType?
        
    lazy var pinnedCollectionViewSection: LastEventsSection = {
        let size = CGSize(width: 0, height: 12)
        let headerConfiguration = TableViewHeaderConfiguration(type: .news, size: size)
        let headerConfigurator = PinnedEventsHeaderConfigurator(data: headerConfiguration)
        
        var items: [CellConfigurator]
        guard let data = data else {
            Log(text: "Team (data) is nil", object: self)
            items = [CellConfigurator]()            
            return LastEventsSection(header: headerConfigurator,
                                     items: items)
        }
        let events = SportEvent.pinnedEvents(team: data, from: 0)
        items = events.map { (event) -> PinnedEventCollectionCellConfigurator in
            PinnedEventCollectionCellConfigurator(data: event)
        }
        var section = LastEventsSection(header: headerConfigurator,
                                        items: items)
        return section
    }()
    
    var sections: [LastEventsSection] {
        var sections = [LastEventsSection]()
        guard let team = data else {
            return sections
        }
        
        var headerConfiguration: TableViewHeaderConfiguration
        var headerConfigurator: CellConfigurator
        var size: CGSize
        
        // Pinned events section
        size = CGSize(width: 0, height: 12)
        headerConfiguration = TableViewHeaderConfiguration(type: .pinnedEvents, size: size)
        headerConfigurator = PinnedEventsHeaderConfigurator(data: headerConfiguration)
        var section = LastEventsSection(header: headerConfigurator,
                                        items: [PinnedEventCellConfigurator(data: SportEvent.empty)])
        sections.append(section)
        
        // Last events section
        size = CGSize(width: 0, height: 40)
        headerConfiguration = TableViewHeaderConfiguration(type: .news, size: size)
        headerConfigurator = EventsHeaderConfigurator(data: headerConfiguration)
        var events: [SportEvent]
        var items: [CellConfigurator]
        events = SportEvent.getLastEvents(team: team, from: 0)
        items = events.map { (event) -> EventCellConfigurator in
            EventCellConfigurator(data: event)
        }
        section = LastEventsSection(header: headerConfigurator,
                                                 items: items)
        sections.append(section)
        
        // Coming events section
        size = CGSize(width: 0, height: 40)
        headerConfiguration = TableViewHeaderConfiguration(type: .comingEvents, size: size)
        headerConfigurator = ComingEventsHeaderConfigurator(data: headerConfiguration)
        events = SportEvent.getComingEvents(team: team, from: 0)
        items = events.map { (event) -> ComingEventCellConfigurator in
            ComingEventCellConfigurator(data: event)
        }
        section = LastEventsSection(header: headerConfigurator,
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
