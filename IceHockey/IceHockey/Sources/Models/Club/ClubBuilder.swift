//
//  ClubBuilder.swift
//  IceHockey
//
//  Created by  Buxlan on 11/22/21.
//

import Foundation

class ClubBuilder {
    
    // MARK: - Properties
    
    typealias DataType = Club
    
    private let objectIdentifier: String
    
    private var databasePart: ClubDatabaseFlowData = EmptyClubDatabaseFlowData()
    private var storagePart: ClubStorageFlowData = EmptyClubStorageFlowData()
    
    private let proxy = ClubProxy()
    
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
            self?.buildStoragePart { [weak self] in
                guard let self = self else { return }
                let object = ClubImpl(databaseData: self.databasePart,
                                           storageData: self.storagePart)
                self.proxy.team = object
            }
        }
    }
    
    private func buildDatabasePart(completionHandler: @escaping () -> Void) {
        let loader = ClubDatabaseLoader(objectIdentifier: objectIdentifier)
        loader.load { [weak self] databaseObject in
            if let databaseObject = databaseObject {
                self?.databasePart = databaseObject
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
        guard imagesIds.count > 0 else {
            completionHandler()
            return
        }
        let loader = ClubStorageDataLoader(objectIdentifier: objectIdentifier,
                                                 imagesIdentifiers: imagesIds)
        loader.load { [weak self] storageObject in
            if let storageObject = storageObject {
                self?.storagePart = storageObject
            }
            completionHandler()
        }
    }
    
    func getResult() -> DataType {
        return proxy
    }
    
}
