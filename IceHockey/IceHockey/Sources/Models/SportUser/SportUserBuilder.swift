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
        log.debug("SportUserBuilder build")
        if objectIdentifier.isEmpty {
            completionHandler()
            return
        }
        activeBuilders.removeAll()
        activeLoaders.removeAll()
        buildDatabasePart { [weak self] in
            self?.buildStoragePart { [weak self] in
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
        log.debug("SportUserBuilder buildDatabasePart")
        if let snapshot = snapshot {
            if let databasePart = SportUserDatabaseFlowDataImpl(snapshot: snapshot) {
                self.databasePart = databasePart
            }
            completionHandler()
        } else {
            let loader = SportUserDatabaseLoader(objectIdentifier: objectIdentifier)
            activeLoaders["DatabaseLoader"] = loader
            loader.load { [weak self] result in
                switch result {
                case .success(let databaseObject):
                    if let databaseObject = databaseObject {
                        self?.databasePart = databaseObject
                    }
                case .failure(let error):
                    log.debug("SquadBuilder buildDatabasePart: error: \(error)")
                    switch error {
                    case .notFound:
                        self?.databasePart.displayName = "Not defined"
                    case .other:
                        fatalError()
                    }
                }
                completionHandler()
            }
        }        
    }
    
    private func buildStoragePart(completionHandler: @escaping () -> Void) {
        log.debug("SportUserBuilder buildStoragePart")
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
