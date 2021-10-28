//
//  SportSquadFirebaseRemover.swift
//  IceHockey
//
//  Created by  Buxlan on 10/29/21.
//

import Firebase

struct SportSquadFirebaseRemover: FirebaseObjectRemover {
    
    // MARK: - Properties
    
    typealias DataType = SportSquad
    var object: FirebaseObject
    
    internal var objectsRootDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("squads")
    }
    
    internal var imagesDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("images")
    }
    
    internal var imagesStorageReference: StorageReference {
        FirebaseManager.shared.storageManager.root.child("squads")
    }
    
    internal var objectDatabaseReference: DatabaseReference {
        objectsRootDatabaseReference.child(object.uid)
    }
    
    // MARK: Lifecircle
    
    // MARK: - Helper methods
    
    func remove(completionHandler: @escaping () -> Void) throws {
        guard let object = self.object as? DataType else {
            throw AppError.dataMismatch
        }
        objectDatabaseReference.removeValue()
        completionHandler()
    }
}
