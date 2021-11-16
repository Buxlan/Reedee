//
//  SportNewsFirebaseRemover.swift
//  IceHockey
//
//  Created by  Buxlan on 11/8/21.
//

import Firebase

struct SportNewsFirebaseRemover: FirebaseObjectRemover {
    
    // MARK: - Properties
    
    typealias DataType = SportNewsDatabaseFlowImpl
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
        objectsRootDatabaseReference.child(object.uid)
    }
    
    // MARK: Lifecircle
    
    // MARK: - Helper methods
    
    func remove() throws {
        
        guard let object = self.object as? DataType else {
            throw AppError.dataMismatch
        }
        imagesStorageReference.child(object.uid).listAll { result, error in
            if let error = error {
                print(error)
                return
            }
            result.items.forEach { ref in
                ref.delete { error in
                    if let error = error {
                        print(error)
                    }
                }
            }
        }
        objectDatabaseReference.removeValue()
    }
}
