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
        print("Loading handlers count: \(loadingHandlers.count)")
        return !loadingHandlers.isEmpty
    }
    
    private var databaseRootPath = "events"
    private lazy var collection = DataSnapshotsCollection(portionSize: portionSize)
    private lazy var iterator = DataSnapshotsIterator(collection: collection)
    
    private let portionSize: UInt
    private var endOfListIsReached: Bool = false
    
    private var loadingHandlers: [String: () -> Void] = [:]
    
    // MARK: - Lifecircle
    
    init(portionSize: UInt = 10) {
        self.portionSize = portionSize
    }
    
    func flush() {
        collection = DataSnapshotsCollection(portionSize: portionSize)
        iterator = DataSnapshotsIterator(collection: collection)
    }
    
    private func loadSnapshots(completionHandler: @escaping (Int) -> Void) {
        let query = prepareQuery()
        query.getData { error, snapshot in
            assert(error == nil)
            var count = 0
            snapshot.children.forEach { child in
                guard let child = child as? DataSnapshot else {
                    return
                }
                self.collection.appendItem(child)
                count += 1
            }
            completionHandler(count)
        }
    }
    
    private func prepareQuery() -> DatabaseQuery {
        var query: DatabaseQuery
        query = FirebaseManager.shared.databaseManager
            .root
            .child(databaseRootPath)
            .queryOrdered(byChild: "order")
            .queryLimited(toFirst: portionSize)
        if !collection.isEmpty {
            guard let objects = iterator.last(),
                  let snapshot = objects.items.last else {
                      assertionFailure()
                      return query
            }
            if let databasePart = SportEventCreator().makeDatabasePart(from: snapshot) {
                query = FirebaseManager.shared.databaseManager
                    .root
                    .child(databaseRootPath)
                    .queryOrdered(byChild: "order")
                    .queryStarting(afterValue: databasePart.order)
                    .queryLimited(toFirst: portionSize)
            }
        }
        return query
    }
    
    func getNextPortion(completionHandler: @escaping ([DataSnapshot]) -> Void) {
        if let data = iterator.next() {
            completionHandler(data.items)
        } else {
            loadSnapshots { loadedSnapshotsCount in
                if loadedSnapshotsCount > 0 {
                    self.getNextPortion(completionHandler: completionHandler)
                }
            }
        }
    }
    
    func load(eventListCompletionHandler: @escaping ([SportEvent]) -> Void,
              eventLoadedCompletionHandler: @escaping () -> Void) {
        var events: [SportEvent] = []
        getNextPortion { snapshots in
            for snapshot in snapshots {
                let eventID = snapshot.key
                let completionHandler: () -> Void = {
                    if let handlerIndex = self.loadingHandlers
                        .firstIndex(where: { (key, _) in
                        key == eventID
                    }) {
                        self.loadingHandlers.remove(at: handlerIndex)
                    }
                    eventLoadedCompletionHandler()
                }
                self.loadingHandlers[eventID] = completionHandler
            }
            for snapshot in snapshots {
                let key = snapshot.key
                guard let handler = self.loadingHandlers[key] else {
                    return
                }
                let creator = SportEventCreator()
                let event = creator.create(snapshot: snapshot, with: handler)
                if let event = event {
                    events.append(event)
                }
            }
            eventListCompletionHandler(events)
        }
    }
    
}
