//
//  DocumentListLoader.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 17.02.2022.
//

import Firebase

class DocumentListLoader {
    
    // MARK: - Properties
    
    var isLoading: Bool {
        print("Loading handlers count: \(loadings.count)")
        return !loadings.isEmpty
    }
    
    private var databaseRootPath = "documents"
    private lazy var collection = DataSnapshotsCollection(portionSize: portionSize)
    private lazy var iterator = DataSnapshotsIterator(collection: collection)
    
    private let portionSize: UInt
    private var endOfListIsReached: Bool = false
    
    private var loadings: [String: (DocumentCreator, () -> Void)] = [:]
    
    // MARK: - Lifecircle
    
    init(portionSize: UInt = 100000) {
        self.portionSize = portionSize
    }
    
    deinit {
        log.debug("deinit DocumentListLoader")
    }
    
    // MARK: - Helper methods
    
    func flush() {
        collection = DataSnapshotsCollection(portionSize: portionSize)
        iterator = DataSnapshotsIterator(collection: collection)
    }
    
    private func loadSnapshots(completionHandler: @escaping (Int) -> Void) {
        let query = prepareQuery()
        query.getData { [weak self] error, snapshot in
            assert(error == nil)
            guard let snapshot = snapshot else {
                assertionFailure()
                return
            }
            var count = 0
            for child in snapshot.children {
                guard let child = child as? DataSnapshot else {
                    return
                }
                self?.collection.appendItem(child)
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
            .queryLimited(toFirst: portionSize)
        if !collection.isEmpty {
            guard let objects = iterator.last(),
                  let snapshot = objects.items.last else {
                      assertionFailure()
                      return query
            }
            if let databasePart = DocumentCreator().makeDatabasePart(from: snapshot) {
                query = FirebaseManager.shared.databaseManager
                    .root
                    .child(databaseRootPath)
                    .queryStarting(afterValue: databasePart.objectIdentifier)
                    .queryLimited(toFirst: portionSize)
            }
        }
        return query
    }
    
    func getNextPortion(completionHandler: @escaping ([DataSnapshot]) -> Void) {
        if let data = iterator.next() {
            completionHandler(data.items)
        } else {
            loadSnapshots { [weak self] loadedSnapshotsCount in
                if loadedSnapshotsCount > 0 {
                    self?.getNextPortion(completionHandler: completionHandler)
                }
            }
        }
    }
    
    func load(objectListCompletionHandler: @escaping ([Document]) -> Void,
              objectLoadedCompletionHandler: @escaping () -> Void) {
        var loadedObjects: [Document] = []
        getNextPortion { [weak self] snapshots in
            guard let self = self else { return }
            for snapshot in snapshots {
                let eventID = snapshot.key
                let completionHandler: () -> Void = { [weak self] in
                    guard let self = self else {
                        return
                    }
                    if let handlerIndex = self.loadings
                        .firstIndex(where: { (key, _) in
                        key == eventID
                    }) {
                        self.loadings.remove(at: handlerIndex)
                    }
                    objectLoadedCompletionHandler()
                }
                self.loadings[eventID] = (DocumentCreator(), completionHandler)
            }
            for snapshot in snapshots {
                let key = snapshot.key
                guard let (creator, handler) = self.loadings[key] else {
                    return
                }
                let object = creator.create(snapshot: snapshot, with: handler)
                if let object = object {
                    loadedObjects.append(object)
                }
            }
            objectListCompletionHandler(loadedObjects)
        }
    }
    
}

