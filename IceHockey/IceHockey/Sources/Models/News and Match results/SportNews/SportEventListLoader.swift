//
//  SportEventListLoader.swift
//  IceHockey
//
//  Created by  Buxlan on 11/20/21.
//

import Firebase

class SportEventListLoader {
    
    // MARK: - Properties
    
    var isLoading: Bool {
        return !loadingHandlers.isEmpty
    }
    var databaseQuery: DatabaseQuery {
        FirebaseManager.shared.databaseManager
            .root
            .child(databaseRootPath)
            .queryOrdered(byChild: "order")
            .queryLimited(toFirst: capacity)
    }
    
    private var databaseRootPath = "events"
    private let capacity: UInt
    private var lastValue: Int?
    private var endOfListIsReached: Bool = false
    private let factory = FirebaseObjectFactory.shared
    
    private var loadingHandlers: [String: () -> Void] = [:]
    
    // MARK: - Lifecircle
    
    init(capacity: UInt = 10) {
        self.capacity = capacity
    }
    
    func flush() {
        lastValue = nil
    }
    
    func load(eventListCompletionHandler: @escaping ([SportEvent]) -> Void,
              eventLoadedCompletionHandler: @escaping (IndexPath) -> Void) {
        if endOfListIsReached {
            return
        }
        var query = databaseQuery
        if let lastValue = lastValue {
            query = query.queryStarting(afterValue: lastValue)
        }
        var events: [SportEvent] = []
        query.getData { error, snapshot in
            assert(error == nil)
            if snapshot.childrenCount < self.capacity {
                self.endOfListIsReached = true
            }
            for (index, child) in snapshot.children.enumerated() {
                guard let child = child as? DataSnapshot else {
                    continue
                }
                let eventID = child.key
                let completionHandler: () -> Void = {
                    if let handlerIndex = self.loadingHandlers
                        .firstIndex(where: { (key, _) in
                        key == eventID
                    }) {
                        self.loadingHandlers.remove(at: handlerIndex)
                    }
                    let indexPath = IndexPath(row: index, section: 0)
                    eventLoadedCompletionHandler(indexPath)
                }
                self.loadingHandlers[eventID] = completionHandler
            }
            for child in snapshot.children {
                guard let child = child as? DataSnapshot else {
                    continue
                }
                let key = child.key
                guard let handler = self.loadingHandlers[key] else {
                    return
                }
                let creator = SportEventCreator()
                let event = creator.create(snapshot: child, with: handler)
                if let event = event {
                    self.lastValue = event.order
                    events.append(event)
                }
            }
            eventListCompletionHandler(events)
        }
    }
    
}
