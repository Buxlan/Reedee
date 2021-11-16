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
    
    func create(snapshot: DataSnapshot) -> SportEvent? {
        
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else { return nil }
        let type = getType(dict)
        var object: SportEvent?
        
        switch type {
        case .event:
            let builder = SportNewsBuilder()
        case .match:
            object = MatchResult(key: uid, dict: dict)
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

struct SportNewsBuilder {
    
    // MARK: - Properties
    
    let key: String
    let dict: [String: Any]
    
    private var databasePart: SportNewsDatabaseFlowData?
    private var storagePart: SportNewsStorageFlowData?
    
    // MARK: - Lifecircle
    
    init(key: String, dict: [String: Any]) {
        self.key = key
        self.dict = dict
    }
    
    // MARK: - Helper Methods
    
    mutating func build(key: String, dict: [String: Any]) {
        buildDatabasePart(key: key, dict: dict)
        buildStoragePart()
    }
    
    private mutating func buildDatabasePart(key: String, dict: [String: Any]) {
        databasePart = SportNewsDatabaseFlowDataImpl(key: key, dict: dict)
    }
    
    private mutating func buildStoragePart() {
        storagePart = SportNewsStorageFlowDataImpl()
    }
    
    func getResult() -> SportEvent? {
        guard let databasePart = databasePart,
              let storagePart = storagePart else {
                  return nil
              }
        let object = SportNews(databaseFlowObject: databasePart,
                               storageFlowObject: storagePart)
        return object
    }
    
}
