//
//  TrainingScheduleListLoader.swift
//  IceHockey
//
//  Created by  Buxlan on 11/21/21.
//

import Firebase

class TrainingScheduleListLoader {
    
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
    
    private var databaseRootPath = "trainingSchedule"
    private let capacity: UInt
    private var lastValue: Int?
    private var endOfListIsReached: Bool = false
    
    private var loadingHandlers: [String: (TrainingSchedule?) -> Void] = [:]
    
    // MARK: - Lifecircle
    
    init(capacity: UInt = 10) {
        self.capacity = capacity
    }
    
    func flush() {
        lastValue = nil
    }
    
    func load(objectListCompletionHandler: @escaping ([TrainingSchedule]) -> Void,
              objectLoadedCompletionHandler: @escaping (TrainingSchedule) -> Void) {
        if endOfListIsReached {
            return
        }
        var query = databaseQuery
        if let lastValue = lastValue {
            query = query.queryStarting(afterValue: lastValue)
        }
        var object: [TrainingSchedule] = []
        query.getData { error, snapshot in
            assert(error == nil)
            if snapshot.childrenCount < self.capacity {
                self.endOfListIsReached = true
            }
            for child in snapshot.children {
                guard let child = child as? DataSnapshot else {
                    continue
                }
                let eventID = child.key
                let completionHandler: (TrainingSchedule?) -> Void = { event in
                    if let handlerIndex = self.loadingHandlers
                        .firstIndex(where: { (key, _) in
                        key == eventID
                    }) {
                        self.loadingHandlers.remove(at: handlerIndex)
                    }
                    guard let event = event else {
                        return
                    }
                    objectLoadedCompletionHandler(event)
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
                let creator = TrainingScheduleCreatorImpl()
                let object = creator.create(snapshot: child, with: handler)
                if let object = object {
                    self.lastValue = object.order
                    objects.append(object)
                }
            }
            eventListCompletionHandler(objects)
        }
    }
    
}
