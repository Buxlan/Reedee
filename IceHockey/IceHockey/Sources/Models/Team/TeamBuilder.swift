//
//  TeamBuilder.swift
//  IceHockey
//
//  Created by  Buxlan on 11/22/21.
//

import Foundation

class TeamBuilder {
    
    // MARK: - Properties
    
    typealias DataType = SportTeam
    
    private let objectIdentifier: String
    
    private var databasePart: TeamDatabaseFlowData
    private var storagePart: TeamStorageFlowData
    
    private let proxy = SportTeamProxy()
    
    // MARK: - Lifecircle
    
    init(objectIdentifier: String) {
        self.objectIdentifier = objectIdentifier
        databasePart = DefaultTeamDatabaseFlowData()
        storagePart = DefaultTeamStorageFlowData()
    }
    
    // MARK: - Helper Methods
    
    func build(completionHandler: @escaping () -> Void) {
        proxy.loadingCompletionHandler = completionHandler
        buildDatabasePart {
            self.buildStoragePart {
                let object = SportTeamImpl(databaseData: self.databasePart,
                                           storageData: self.storagePart)
                self.proxy.team = object
            }
        }
    }
    
    private func buildDatabasePart(completionHandler: @escaping () -> Void) {
        let loader = SportTeamDatabaseLoader(objectIdentifier: objectIdentifier)
        loader.load { databaseObject in
            if let databaseObject = databaseObject {
                self.databasePart = databaseObject
            }
            completionHandler()
        }
    }
    
    private func buildStoragePart(completionHandler: @escaping () -> Void) {
        var imagesIds: [String] = []
        if !databasePart.largeLogoID.isEmpty {
            imagesIds.append(databasePart.largeLogoID)
        }
        if !databasePart.smallLogoID.isEmpty {
            imagesIds.append(databasePart.smallLogoID)
        }
//        guard imagesIds.count > 0 else {
//            completionHandler()
//            return
//        }
        let loader = SportTeamStorageDataLoader(objectIdentifier: objectIdentifier,
                                                 imagesIdentifiers: imagesIds)
        loader.load { storageObject in
            if let storageObject = storageObject {
                self.storagePart = storageObject
            }
            completionHandler()
        }
    }
    
    func getResult() -> DataType {
        return proxy
    }
    
}
