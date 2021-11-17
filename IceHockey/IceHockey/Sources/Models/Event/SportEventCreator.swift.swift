//
//  SportEventCreator.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 11/6/21.
//

import Firebase

protocol SportEventCreator {
    
    func create(snapshot: DataSnapshot,
                with completionHandler: @escaping (SportEvent?) -> Void)
    -> SportEvent?
    
}

struct SportEventCreatorImpl: SportEventCreator {
    
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
    
    private var databasePart: SportNewsDatabaseFlowData
    private var storagePart: SportNewsStorageFlowData
    private var author: SportUser
    
    private var completionHandler: (SportEvent?) -> Void = { _ in }
    
    // MARK: - Lifecircle
    
    init(key: String, dict: [String: Any]) {
        self.key = key
        self.dict = dict
        databasePart = DefaultSportNewsDatabaseFlowData()
        storagePart = DefaultSportNewsStorageFlowData()
        author = SportUser()
    }
    
    // MARK: - Helper Methods
    
    func build(completionHandler: @escaping (SportEvent?) -> Void) {
        self.completionHandler = completionHandler
        buildDatabasePart {
            self.buildStoragePart {
                self.buildAuthor()
            }
        }
    }
    
    private func buildDatabasePart(completionHandler: @escaping () -> Void) {
        guard let databasePart = SportNewsDatabaseFlowDataImpl(key: key, dict: dict) else {
            self.completionHandler(nil)
            return
        }
        self.databasePart = databasePart
        completionHandler()
    }
    
    private func buildStoragePart(completionHandler: @escaping () -> Void) {
        guard !databasePart.uid.isEmpty else {
                  self.completionHandler(nil)
                  return
              }
        storagePart = SportNewsStorageFlowDataImpl(eventID: databasePart.uid, imageIDs: databasePart.imageIDs)
        storagePart.load {
            completionHandler()
        }
    }
    
    private func buildAuthor() {
        let builder = SportUserBuilder(key: databasePart.author)
        builder.build { user in
            if let user = user {
                self.author = user
            }
            self.completionHandler(self.getResult())
        }
    }
    
    func getResult() -> SportNews? {
        let object = SportNews(databaseFlowObject: databasePart,
                               storageFlowObject: storagePart,
                               author: author)
        return object
    }
    
}
