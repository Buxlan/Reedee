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
    private var snapshot: DataSnapshot?
    
    private var databasePart: SportUserDatabaseFlowData = SportUserDatabaseFlowDataImpl.empty
    private var storagePart: StorageFlowData = EmptyStorageFlowData()
    
    private let proxy = SportUserProxy()
    
    private var completionHandler: () -> Void = {}
    
    // MARK: - Lifecircle
    
    init(snapshot: DataSnapshot) {
        self.key = snapshot.key
        self.snapshot = snapshot
    }
    
    init(key: String) {
        self.key = key
    }
    
    // MARK: - Helper Methods
    
    func build(completionHandler: @escaping () -> Void) {
        if key.isEmpty {
            completionHandler()
            return
        }
        proxy.loadingCompletionHandler = completionHandler
        buildDatabasePart {
            self.buildStoragePart {
                let object = SportUserImpl(databaseData: self.databasePart,
                                           storageData: self.storagePart)
                self.proxy.user = object
            }
        }
    }
    
    private func buildDatabasePart(completionHandler: @escaping () -> Void) {
        if let snapshot = snapshot {
            if let databasePart = SportUserDatabaseFlowDataImpl(snapshot: snapshot) {
                self.databasePart = databasePart
            }
            completionHandler()
        } else {
            let loader = SportUserDatabaseLoader(objectIdentifier: key)
            loader.load { data in
                if let data = data {
                    self.databasePart = data
                }
                completionHandler()
            }
        }        
    }
    
    private func buildStoragePart(completionHandler: @escaping () -> Void) {
        guard !databasePart.objectIdentifier.isEmpty,
              !databasePart.imageID.isEmpty else {
                  completionHandler()
                  return
              }
        let loader = UserImageLoader(objectIdentifier: databasePart.objectIdentifier,
                                     imageIdentifier: databasePart.imageID)
        loader.load { data in
            if let data = data {
                self.storagePart = data
            }
            completionHandler()
        }
    }
    
    func getResult() -> SportUser {
        return proxy
    }
    
}
