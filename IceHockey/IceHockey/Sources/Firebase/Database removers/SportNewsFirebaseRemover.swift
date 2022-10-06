//
//  SportNewsFirebaseRemover.swift
//  IceHockey
//
//  Created by  Buxlan on 11/8/21.
//

import Firebase

struct SportNewsFirebaseRemover: FirebaseObjectRemover {
    
    // MARK: - Properties
    
    typealias DataType = SportNews
    var object: FirebaseObject
    
    internal var objectsRootDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("events")
    }
    
    internal var imagesDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("images")
    }
    
    internal var imagesStorageReference: StorageReference {
        FirebaseManager.shared.storageManager.root.child("events")
    }
    
    internal var objectDatabaseReference: DatabaseReference {
        objectsRootDatabaseReference.child(object.objectIdentifier)
    }
    
    // MARK: Lifecircle
    
    // MARK: - Helper methods
    
    func remove(completionHandler: @escaping (FirebaseRemoveError?) -> Void) {
        
        guard let object = self.object as? DataType else {
            completionHandler(FirebaseRemoveError.dataMismatch)
            return
        }
        
        imagesStorageReference
            .child(object.objectIdentifier)
            .listAll { result, error in
                guard error == nil else {
                    completionHandler(FirebaseRemoveError.storageError)
                    return
                }
                result?.items.forEach { ref in
                    ref.delete { _ in }
                }
            }
        objectDatabaseReference.removeValue()
        completionHandler(nil)
    }
}
