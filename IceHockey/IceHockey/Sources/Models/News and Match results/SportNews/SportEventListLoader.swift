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
    
    private var databaseRootPath = "events"
    private var collection = DataSnapshotsCollection()
    private lazy var iterator = DataSnapshotsIterator(collection: collection)
    private var collectionCapacity: UInt = 10
    
    private let portion: UInt
    private var endOfListIsReached: Bool = false
    private let factory = FirebaseObjectFactory.shared
    
    private var loadingHandlers: [String: () -> Void] = [:]
    
    // MARK: - Lifecircle
    
    init(portion: UInt = 10) {
        self.portion = portion
    }
    
    func flush() {
        iterator.first()
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
                self.collection.append(child)
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
            .queryLimited(toFirst: collectionCapacity)
        if !collection.isEmpty {
            iterator.last()
            guard let objects = iterator.next(),
                  let snapshot = objects.items.last else {
                fatalError()
            }
            if let databasePart = SportEventCreator().makeDatabasePart(from: snapshot) {
                query = FirebaseManager.shared.databaseManager
                    .root
                    .child(databaseRootPath)
                    .queryOrdered(byChild: "order")
                    .queryStarting(afterValue: databasePart.order)
                    .queryLimited(toFirst: collectionCapacity)
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
