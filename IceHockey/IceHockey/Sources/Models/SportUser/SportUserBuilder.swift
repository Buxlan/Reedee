//
//  SportUserBuilder.swift
//  IceHockey
//
//  Created by  Buxlan on 11/18/21.
//

import Firebase

class SportUserBuilder {
    
    // MARK: - Properties
    
    private let key: String
    private let dict: [String: Any] = [:]
    
    private var databasePart: SportUserDatabaseFlowData?
    private var storagePart: SportUserStorageFlowData?
    private var snapshot: DataSnapshot?
    
    private var completionHandler: (SportUser?) -> Void = { _ in }
    
    // MARK: - Lifecircle
    
    init(snapshot: DataSnapshot) {
        self.key = snapshot.key
        self.snapshot = snapshot
    }
    
    init(key: String) {
        self.key = key
    }
    
    // MARK: - Helper Methods
    
    func build(completionHandler: @escaping (SportUser?) -> Void) {
        databasePart = nil
        storagePart = nil
        if key.isEmpty {
            return
        }
        self.completionHandler = completionHandler
        buildDatabasePart {
            self.buildStoragePart()
        }
    }
    
    private func buildDatabasePart(completionHandler: @escaping () -> Void) {
        if let snapshot = snapshot {
            self.databasePart = SportUserDatabaseFlowDataImpl(snapshot: snapshot)
            completionHandler()
        } else {
            let path = "users"
            FirebaseManager.shared.databaseManager
                .root
                .child(path)
                .child(key)
                .getData { error, snapshot in
                    assert(error == nil)
                    self.databasePart = SportUserDatabaseFlowDataImpl(snapshot: snapshot)
                    completionHandler()
                }
        }        
    }
    
    private func buildStoragePart() {
        guard let databasePart = databasePart,
              !databasePart.uid.isEmpty else {
                  completionHandler(nil)
                  return
              }
        storagePart = SportUserStorageFlowDataImpl(imageID: databasePart.imageID)
        storagePart?.load {
            self.completionHandler(self.getResult())
        }
    }
    
    func getResult() -> SportUser? {
        guard let databasePart = databasePart,
              let storagePart = storagePart else {
                  return nil
              }
        let object = SportUser(databaseFlowObject: databasePart,
                                   storageFlowObject: storagePart)
        return object
    }
    
}
