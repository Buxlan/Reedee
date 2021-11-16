//
//  SportEventCreator.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 11/6/21.
//

import Firebase

protocol SportEventCreator {
    
    func create(snapshot: DataSnapshot) -> SportEvent?
    
}

struct SportEventCreatorImpl {
    
    func create(snapshot: DataSnapshot,
                with completionHandler: @escaping (SportEvent?) -> Void)
    -> SportEvent? {
        
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else { return nil }
        let type = getType(dict)
        var object: SportEvent?
        
        switch type {
        case .event:
            let builder = SportNewsBuilder(key: uid, dict: dict)
            builder.build(completionHandler: completionHandler)
            object = builder.getResult()
        case .match:
            object = MatchResult(key: uid, dict: dict)
            completionHandler(nil)
        default:
            object = nil
        }
        
        return object
        
    }
    
    private func getType(_ dict: [String: Any]) -> SportEventType? {
        guard let rawType = dict["type"] as? Int,
              let type = SportEventType(rawValue: rawType) else { return nil }
        return type
    }
    
}

class SportNewsBuilder {
    
    // MARK: - Properties
    
    private let key: String
    private let dict: [String: Any]
    
    private var databasePart: SportNewsDatabaseFlowData?
    private var storagePart: SportNewsStorageFlowData?
    
    private var completionHandler: (SportEvent?) -> Void = { _ in }
    
    // MARK: - Lifecircle
    
    init(key: String, dict: [String: Any]) {
        self.key = key
        self.dict = dict
    }
    
    // MARK: - Helper Methods
    
    func build(completionHandler: @escaping (SportEvent?) -> Void) {
        self.completionHandler = completionHandler
        buildDatabasePart()
        buildStoragePart()
    }
    
    private func buildDatabasePart() {
        databasePart = SportNewsDatabaseFlowDataImpl(key: key, dict: dict)
    }
    
    private func buildStoragePart() {
        guard let databasePart = databasePart,
              !databasePart.uid.isEmpty else {
                  return
              }
        storagePart = SportNewsStorageFlowDataImpl(eventID: databasePart.uid, imageIDs: databasePart.imageIDs)
        let handler = {
            self.completionHandler(self.getResult())
        }
        storagePart?.load(with: handler)
    }
    
    func getResult() -> SportNews? {
        guard let databasePart = databasePart,
              let storagePart = storagePart else {
                  return nil
              }
        let object = SportNews(databaseFlowObject: databasePart,
                               storageFlowObject: storagePart)
        return object
    }
    
}
