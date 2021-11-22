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
    private var dict: [String: Any] = [:]
    
    private var databasePart: TeamDatabaseFlowData
    private var storagePart: TeamStorageFlowData
    
    private var completionHandler: (DataType?) -> Void = { _ in }
    
    // MARK: - Lifecircle
    
    init(objectIdentifier: String) {
        self.objectIdentifier = objectIdentifier
        databasePart = DefaultTeamDatabaseFlowData()
        storagePart = DefaultTeamStorageFlowData()
    }
    
    // MARK: - Helper Methods
    
    func build(completionHandler: @escaping (DataType?) -> Void) {
        self.completionHandler = completionHandler
        buildDatabasePart {
            self.buildStoragePart()
        }
    }
    
    private func buildDatabasePart(completionHandler: @escaping () -> Void) {
        let loader = SportTeamDatabaseLoader(objectIdentifier: objectIdentifier)
        loader.load { databaseObject in
            guard let databaseObject = databaseObject else {
                self.completionHandler(nil)
                return
            }
            self.databasePart = databaseObject
            completionHandler()
        }
    }
    
    private func buildStoragePart() {
        guard !databasePart.objectIdentifier.isEmpty else {
                  self.completionHandler(nil)
                  return
              }
        let imagesIds = [databasePart.largeLogoID,
                         databasePart.smallLogoID]
        let loader = SportTeamStorageDataLoader(objectIdentifier: objectIdentifier,
                                                 imagesIdentifiers: imagesIds)
        loader.load { storageObject in
            guard let storageObject = storageObject else {
                self.completionHandler(nil)
                return
            }
            self.storagePart = storageObject
            self.completionHandler(self.getResult())
        }
    }
    
    func getResult() -> DataType? {
        let object = DataType(databaseData: databasePart,
                              storageData: storagePart)
        return object
    }
    
}
