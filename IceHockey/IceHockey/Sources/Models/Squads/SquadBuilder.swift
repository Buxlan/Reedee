//
//  SquadBuilder.swift
//  IceHockey
//
//  Created by  Buxlan on 11/22/21.
//

import Foundation

class SquadBuilder {
    
    // MARK: - Properties
    
    typealias DataType = Squad
    
    private let objectIdentifier: String
    
    private var databasePart: SquadDatabaseFlowData = SquadDatabaseFlowDataImpl.empty
    private var storagePart: StorageFlowData = EmptyStorageFlowData()
    
    private let proxy = SquadProxy()
    private var activeBuilders: [String: FirebaseObjectBuilder] = [:]
    private var activeLoaders: [String: FirebaseLoader] = [:]
    
    // MARK: - Lifecircle
    
    init(objectIdentifier: String) {
        self.objectIdentifier = objectIdentifier
    }
    
    // MARK: - Helper Methods
    
    func build(completionHandler: @escaping () -> Void) {
        guard !objectIdentifier.isEmpty else {
            completionHandler()
            return
        }
        self.activeBuilders.removeAll()
        self.activeLoaders.removeAll()
        buildDatabasePart { [weak self] in
            self?.buildStoragePart {
                guard let self = self else { return }
                let object = SquadImpl(databaseData: self.databasePart,
                                       storageData: self.storagePart)
                self.proxy.squad = object
                completionHandler()
                self.activeBuilders.removeAll()
                self.activeLoaders.removeAll()
            }
        }
    }
    
    private func buildDatabasePart(completionHandler: @escaping () -> Void) {
        let loader = SquadDatabaseLoader(objectIdentifier: objectIdentifier)
        activeLoaders["DatabaseLoader"] = loader
        loader.load { [weak self] databaseObject in
            if let databaseObject = databaseObject {
                self?.databasePart = databaseObject
            }
            completionHandler()
        }
    }
    
    private func buildStoragePart(completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func getResult() -> DataType {
        return proxy
    }
    
}
