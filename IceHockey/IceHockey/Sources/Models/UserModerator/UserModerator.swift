//
//  UserModerator.swift
//  IceHockey
//
//  Created by  Buxlan on 11/17/21.
//

import Firebase

class UserModerator {
    
    var uid: String {
        firebaseUser?.uid ?? "---no ID---"
    }
    var displayName: String {
        firebaseUser?.displayName ?? "---Unknown---"
    }
    var image: UIImage? {
        return storageFlowObject.image?.image ?? nil
    }
    
    var firebaseUser: User? {
        return Auth.auth().currentUser
    }
    
    private var databaseFlowObject: UserModeratorDatabaseFlowData
    private var storageFlowObject: UserModeratorStorageFlowData
    
    init() {
        self.databaseFlowObject = UserModeratorDatabaseFlowDataImpl()
        self.storageFlowObject = UserModeratorStorageFlowDataImpl()
    }
    
    init(databaseFlowObject: UserModeratorDatabaseFlowData,
         storageFlowObject: UserModeratorStorageFlowData) {
        self.databaseFlowObject = databaseFlowObject
        self.storageFlowObject = storageFlowObject
    }
    
}

protocol UserModeratorCreator {
    
    func create(snapshot: DataSnapshot,
                with completionHandler: @escaping (UserModerator?) -> Void)
    -> UserModerator?
    
}

struct UserModeratorCreatorImpl: UserModeratorCreator {
    
    func create(snapshot: DataSnapshot,
                with completionHandler: @escaping (UserModerator?) -> Void)
    -> UserModerator? {
        
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else { return nil }
        
        let builder = SportUserBuilder(key: uid, dict: dict)
        builder.build(completionHandler: completionHandler)
        let object = builder.getResult()
        return object
    }
    
}

class SportUserBuilder {
    
    // MARK: - Properties
    
    private let key: String
    private let dict: [String: Any]
    
    private var databasePart: UserModeratorDatabaseFlowData?
    private var storagePart: UserModeratorStorageFlowData?
    
    private var completionHandler: (UserModerator?) -> Void = { _ in }
    
    // MARK: - Lifecircle
    
    init(key: String, dict: [String: Any]) {
        self.key = key
        self.dict = dict
    }
    
    // MARK: - Helper Methods
    
    func build(completionHandler: @escaping (UserModerator?) -> Void) {
        self.completionHandler = completionHandler
        buildDatabasePart()
        buildStoragePart()
    }
    
    private func buildDatabasePart() {
        databasePart = UserModeratorDatabaseFlowDataImpl(key: key, dict: dict)
    }
    
    private func buildStoragePart() {
        guard let databasePart = databasePart,
              !databasePart.uid.isEmpty else {
                  return
              }
        storagePart = UserModeratorStorageFlowDataImpl(imageID: databasePart.imageID)
        let handler = {
            self.completionHandler(self.getResult())
        }
        storagePart?.load(with: handler)
    }
    
    func getResult() -> UserModerator? {
        guard let databasePart = databasePart,
              let storagePart = storagePart else {
                  return nil
              }
        let object = UserModerator(databaseFlowObject: databasePart,
                                   storageFlowObject: storagePart)
        return object
    }
    
}
