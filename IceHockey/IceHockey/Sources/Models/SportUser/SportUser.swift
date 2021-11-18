//
//  SportUser.swift
//  IceHockey
//
//  Created by  Buxlan on 11/17/21.
//

import Firebase

protocol SportUserObject: FirebaseObject {
    var displayName: String { get set }
    var imageID: String { get set }
    var isNew: Bool { get }
}

extension SportUserObject {
    var isNew: Bool {
        return uid.isEmpty
    }
}

class SportUser: SportUserObject {
    
    var uid: String {
        get {
            databaseFlowObject.uid
        }
        set {
            databaseFlowObject.uid = newValue
        }
    }
    var displayName: String {
        get {
            databaseFlowObject.displayName
        }
        set {
            databaseFlowObject.displayName = newValue
        }
    }
    internal var imageID: String {
        get {
            databaseFlowObject.imageID
        }
        set {}
    }
    var image: UIImage? {
        get {
            storageFlowObject.image?.image
        }
        set {
            storageFlowObject.image?.image = newValue
        }
    }
    
    var firebaseUser: User? {
        return Auth.auth().currentUser
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
