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
        proxy.loadingCompletionHandler = completionHandler
        buildDatabasePart { [weak self] in
            self?.buildStoragePart {
                guard let self = self else { return }
                let object = SquadImpl(databaseData: self.databasePart,
                                       storageData: self.storagePart)
                self.proxy.squad = object
            }
        }
    }
    
    private func buildDatabasePart(completionHandler: @escaping () -> Void) {
        let loader = SquadDatabaseLoader(objectIdentifier: objectIdentifier)
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
