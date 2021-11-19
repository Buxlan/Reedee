//
//  SportEventListLoader.swift
//  IceHockey
//
//  Created by  Buxlan on 11/20/21.
//

import Firebase

class SportEventListLoader {
    
    // MARK: - Properties
    
    private let capacity: UInt
    private var lastValue: Int?
    
    private var loadingHandlers: [String: (SportEvent?) -> Void] = [:]
    var isLoading: Bool {
        return !loadingHandlers.isEmpty
    }
    var databaseQuery: DatabaseQuery {
        FirebaseManager.shared.databaseManager.root.child("events")
            .queryOrdered(byChild: "order")
            .queryLimited(toFirst: capacity)
    }
    
    // MARK: - Lifecircle
    
    init(capacity: UInt = 4) {
        self.capacity = capacity
    }
    
    func flush() {
        lastValue = nil
    }
    
    func load(eventListCompletionHandler: @escaping ([SportEvent]) -> Void,
              eventLoadedCompletionHandler: @escaping (SportEvent) -> Void) {
        var query = databaseQuery
        if let lastValue = lastValue {
            query = query.queryStarting(afterValue: lastValue)
        }
        var events: [SportEvent] = []
        query.getData { error, snapshot in
            assert(error == nil)
            self.loadingHandlers.removeAll()
            for child in snapshot.children {
                guard let child = child as? DataSnapshot else {
                    continue
                }
                let eventID = child.key
                let completionHandler: (SportEvent?) -> Void = { event in
                    if let handlerIndex = self.loadingHandlers
                        .firstIndex(where: { (key, _) in
                        key == eventID
                    }) {
                        self.loadingHandlers.remove(at: handlerIndex)
                    }
                    guard let event = event else {
                        return
                    }
                    eventLoadedCompletionHandler(event)
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
                let creator = SportEventCreatorImpl()
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
