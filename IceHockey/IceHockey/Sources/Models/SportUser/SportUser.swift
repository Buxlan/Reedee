//
//  SportUser.swift
//  IceHockey
//
//  Created by  Buxlan on 11/17/21.
//

import Firebase

protocol SportUserObject {
    var uid: String { get set }
    var displayName: String { get set }
    var image: UIImage? { get set }
    var firebaseUser: User? { get set }
    var isNew: Bool { get }
}

extension SportUserObject {
    var isNew: Bool {
        return uid.isEmpty
    }
}

class SportUser {
    
    var uid: String {
        databaseFlowObject.uid
    }
    var displayName: String {
        databaseFlowObject.displayName
    }
    var image: UIImage? {
        return storageFlowObject.image?.image ?? nil
    }
    
    var firebaseUser: User? {
        return Auth.auth().currentUser
    }
    
    var isNew: Bool {
        return uid.isEmpty
    }
    
    private var databaseFlowObject: SportUserDatabaseFlowData
    private var storageFlowObject: SportUserStorageFlowData
    
    init() {
        self.databaseFlowObject = SportUserDatabaseFlowDataImpl()
        self.storageFlowObject = SportUserStorageFlowDataImpl()
    }
    
    init(databaseFlowObject: SportUserDatabaseFlowData,
         storageFlowObject: SportUserStorageFlowData) {
        self.databaseFlowObject = databaseFlowObject
        self.storageFlowObject = storageFlowObject
    }
    
}

protocol SportUserCreator {
    
    func create(snapshot: DataSnapshot,
                with completionHandler: @escaping (SportUser?) -> Void)
    -> SportUser?
    
}

struct SportUserCreatorImpl: SportUserCreator {
    
    func create(snapshot: DataSnapshot,
                with completionHandler: @escaping (SportUser?) -> Void)
    -> SportUser? {
        
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else {
            return nil
        }
        let builder = SportUserBuilder(key: uid)
        builder.build(completionHandler: completionHandler)
        let object = builder.getResult()
        return object
    }
    
}

class SportUserBuilder {
    
    // MARK: - Properties
    
    private let key: String
    private let dict: [String: Any] = [:]
    
    private var databasePart: SportUserDatabaseFlowData?
    private var storagePart: SportUserStorageFlowData?
    
    private var completionHandler: (SportUser?) -> Void = { _ in }
    
    // MARK: - Lifecircle
    
    init(key: String) {
        self.key = key
    }
    
    // MARK: - Helper Methods
    
    func build(completionHandler: @escaping (SportUser?) -> Void) {
        databasePart = nil
        storagePart = nil
        if key.isEmpty {
            return
        }
        self.completionHandler = completionHandler
        buildDatabasePart {
            self.buildStoragePart()
        }
    }
    
    private func buildDatabasePart(completionHandler: @escaping () -> Void) {
        let path = "users"
        FirebaseManager.shared.databaseManager
            .root
            .child(path)
            .child(key)
            .getData { error, snapshot in
                assert(error == nil)
                self.databasePart = SportUserDatabaseFlowDataImpl(snapshot: snapshot)
                completionHandler()
            }
        
    }
    
    private func buildStoragePart() {
        guard let databasePart = databasePart,
              !databasePart.uid.isEmpty else {
                  completionHandler(nil)
                  return
              }
        storagePart = SportUserStorageFlowDataImpl(imageID: databasePart.imageID)
        storagePart?.load {
            self.completionHandler(self.getResult())
        }
    }
    
    func getResult() -> SportUser? {
        guard let databasePart = databasePart,
              let storagePart = storagePart else {
                  return nil
              }
        let object = SportUser(databaseFlowObject: databasePart,
                                   storageFlowObject: storagePart)
        return object
    }
    
}
