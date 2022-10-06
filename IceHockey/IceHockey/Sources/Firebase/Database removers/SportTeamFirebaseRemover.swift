//
//  SportTeamFirebaseRemover.swift
//  IceHockey
//
//  Created by  Buxlan on 10/29/21.
//

import Firebase

enum AppError: Error {
    case dataMismatch
    case storageError
    case databaseError
}

struct SportTeamFirebaseRemover: FirebaseObjectRemover {
    
    // MARK: - Properties
    
    typealias DataType = Club
    var object: FirebaseObject
    
    internal var objectsRootDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("teams")
    }
    
    internal var imagesDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("images")
    }
    
    internal var imagesStorageReference: StorageReference {
        FirebaseManager.shared.storageManager.root.child("teams")
    }
    
    internal var objectDatabaseReference: DatabaseReference {
        objectsRootDatabaseReference.child(object.objectIdentifier)
    }
    
    // MARK: Lifecircle
    
    // MARK: - Helper methods
        
    func remove(completionHandler: @escaping (FirebaseRemoveError?) -> Void) {
        guard let object = self.object as? DataType else {
            completionHandler(.dataMismatch)
            return
        }
        objectDatabaseReference.removeValue()
        let smallImageID = object.smallLogoID
        if !smallImageID.isEmpty {
            let imageStorageRef = imagesStorageReference
                .child(object.objectIdentifier)
                .child(smallImageID)
            imageStorageRef.delete { _ in }
        }
        
        let largeImageID = object.largeLogoID
        if !largeImageID.isEmpty {
            let imageRef = imagesStorageReference
                .child(object.objectIdentifier)
                .child(largeImageID)
            imageRef.delete { _ in }
        }
        completionHandler(nil)
    }    
}
