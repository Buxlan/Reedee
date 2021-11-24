//
//  SportUser.swift
//  IceHockey
//
//  Created by  Buxlan on 11/17/21.
//

import Firebase

protocol SportUser: FirebaseObject {
    var displayName: String { get set }
    var imageID: String { get set }
    var isNew: Bool { get }
    var image: UIImage? { get set }
}

extension SportUser {
    var firebaseUser: User? {
        return Auth.auth().currentUser
    }
}

struct SportUserImpl: SportUser {
    
    var objectIdentifier: String {
        get { databaseData.objectIdentifier }
        set { databaseData.objectIdentifier = newValue }
    }
    var displayName: String {
        get { databaseData.displayName }
        set { databaseData.displayName = newValue }
    }
    internal var imageID: String {
        get { databaseData.imageID }
        set { databaseData.imageID = newValue }
    }
    var image: UIImage? {
        get {
            return storageData.images.count > 0 ? storageData.images[0].image : nil
        }
        set {
            if storageData.images.count > 0 {
                storageData.images[0].image = newValue
            } else {
                let imageData = ImageData(imageID: imageID,
                                          image: newValue,
                                          isNew: true)
                storageData.images.append(imageData)
            }
        }
    }
    
    private var databaseData: SportUserDatabaseFlowData = SportUserDatabaseFlowDataImpl.empty
    private var storageData: StorageFlowData = StorageFlowDataImpl()
    
    init(databaseData: SportUserDatabaseFlowData,
         storageData: StorageFlowData) {
        self.databaseData = databaseData
        self.storageData = storageData
    }
    
}
