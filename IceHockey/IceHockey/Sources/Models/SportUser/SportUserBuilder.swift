//
//  SportUserBuilder.swift
//  IceHockey
//
//  Created by  Buxlan on 11/18/21.
//

import Firebase

class SportUserBuilder: FirebaseObjectBuilder {
    
    // MARK: - Properties
    
    private let objectIdentifier: String
    private var snapshot: DataSnapshot?
    
    private var databasePart: SportUserDatabaseFlowData = SportUserDatabaseFlowDataImpl.empty
    private var storagePart: StorageFlowData = EmptyStorageFlowData()
    
    private let proxy = SportUserProxy()
    private var activeBuilders: [String: FirebaseObjectBuilder] = [:]
    private var activeLoaders: [String: FirebaseLoader] = [:]
    
    // MARK: - Lifecircle
    
    init(snapshot: DataSnapshot) {
        self.objectIdentifier = snapshot.key
        self.snapshot = snapshot
    }
    
    required init(objectIdentifier: String) {
        self.objectIdentifier = objectIdentifier
    }
    
    deinit {
        print("deinit \(type(of: self))")
    }
    
    // MARK: - Helper Methods
    
    func build(completionHandler: @escaping () -> Void) {
        if objectIdentifier.isEmpty {
            completionHandler()
            return
        }
        self.activeBuilders.removeAll()
        self.activeLoaders.removeAll()
        buildDatabasePart { [weak self] in
            self?.buildStoragePart {
                guard let self = self else { return }
                let object = SportUserImpl(databaseData: self.databasePart,
                                           storageData: self.storagePart)
                self.proxy.user = object
                completionHandler()
                self.activeBuilders.removeAll()
                self.activeLoaders.removeAll()
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
            let loader = SportUserDatabaseLoader(objectIdentifier: objectIdentifier)
            activeLoaders["DatabaseLoader"] = loader
            loader.load { [weak self] data in
                if let data = data {
                    self?.databasePart = data
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
        activeLoaders["ImageLoader"] = loader
        loader.load { [weak self] data in
            if let data = data {
                self?.storagePart = data
            }
            completionHandler()
        }
    }
    
    func getResult() -> SportUser {
        return proxy
    }
    
}
