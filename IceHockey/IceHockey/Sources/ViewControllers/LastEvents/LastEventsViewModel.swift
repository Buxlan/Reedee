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
        
    var pinnedEventsItems = [CellConfigurator]()
    var items = [CellConfigurator]()
    
    init(data: DataType? = nil) {
        self.data = data
    }
    
    mutating func item(at index: IndexPath) -> CellConfigurator {        
        return items[index.row]
    }
    
    mutating func update() {
        updatePinnedItems()
        updateItems()
    }
    
    private mutating func updatePinnedItems() {
        var items = [CellConfigurator]()
        guard let data = data else {
            Log(text: "Team (data) is nil", object: self)
            return
        }
        let events = SportEvent.pinnedEvents(team: data, from: 0)
        pinnedEventsItems = events.map { (event) -> PinnedEventCollectionCellConfigurator in
            PinnedEventCollectionCellConfigurator(data: event)
        }
    }
    
    private mutating func updateItems() {
        var items = [CellConfigurator]()
        guard data != nil else {
            Log(text: "Team (data) is nil", object: self)
            return
        }
        // 1) Pinned events section
        // Header is absent
        items.append(PinnedEventTableCellConfigurator(data: SportEvent.empty))
        
        // 2) News section
        items.append(contentsOf: prepareNews())
        
        // 3) Coming events section
        items.append(contentsOf: prepareComingEvents())
                               
        self.items = items
    }
    
    private func prepareNews() -> [CellConfigurator] {
        var items = [CellConfigurator]()
        guard let data = data else {
            return items
        }
        let configuration = NewsTableViewCellHeaderConfiguration()
        let header = NewsTableViewHeaderConfigurator(data: configuration)
        items.append(header)
        let events = SportEvent.getLastEvents(team: data, from: 0)
        let cells = events.map { (event) -> EventCellConfigurator in
            EventCellConfigurator(data: event)
        }
        items.append(contentsOf: cells)
        return items
    }
    
    private func prepareComingEvents() -> [CellConfigurator] {
        var items = [CellConfigurator]()
        guard let data = data else {
            return items
        }
        let configuration = ComingEventsTableViewCellHeaderConfiguration()
        let header = ComingEventsHeaderConfigurator(data: configuration)
        items.append(header)
        let events = SportEvent.getComingEvents(team: data, from: 0)
        let cells = events.map { (event) -> ComingEventCellConfigurator in
            ComingEventCellConfigurator(data: event)
        }
        items.append(contentsOf: cells)
        return items
    }
}
