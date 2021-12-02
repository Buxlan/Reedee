//
//  ClubBuilder.swift
//  IceHockey
//
//  Created by  Buxlan on 11/22/21.
//

import Foundation

class ClubBuilder: FirebaseObjectBuilder {
    
    // MARK: - Properties
    
    typealias DataType = ClubProxy
    
    private let objectIdentifier: String
    
    private var databasePart: ClubDatabaseFlowData = EmptyClubDatabaseFlowData()
    private var storagePart: StorageFlowData = EmptyStorageFlowData()
    
    private let proxy = ClubProxy()
    private var activeBuilders: [String: FirebaseObjectBuilder] = [:]
    private var activeLoaders: [String: FirebaseLoader] = [:]
    
    // MARK: - Lifecircle
    
    required init(objectIdentifier: String) {
        self.objectIdentifier = objectIdentifier
    }
    
    deinit {
        print("deinit \(type(of: self))")
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
            self?.buildStoragePart { [weak self] in
                guard let self = self else { return }
                let object = ClubImpl(databaseData: self.databasePart,
                                           storageData: self.storagePart)
                self.proxy.team = object
                completionHandler()
                self.activeBuilders.removeAll()
                self.activeLoaders.removeAll()
            }
        }
    }
    
    private func buildDatabasePart(completionHandler: @escaping () -> Void) {
        let loader = ClubDatabaseLoader(objectIdentifier: objectIdentifier)
        activeLoaders["DatabaseLoader"] = loader
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
        activeLoaders["StorageLoader"] = loader
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
