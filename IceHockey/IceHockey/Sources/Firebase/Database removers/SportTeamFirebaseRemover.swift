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
    
    typealias DataType = SportTeam
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
        objectsRootDatabaseReference.child(object.uid)
    }
    
    // MARK: Lifecircle
    
    // MARK: - Helper methods
    
    func remove() throws {
        guard let object = self.object as? DataType else {
            throw AppError.dataMismatch
        }
        objectDatabaseReference.removeValue()
        let smallImageID = object.smallImageID
        if !smallImageID.isEmpty {
            let imageRef = imagesStorageReference.child(smallImageID)
            imageRef.delete { (error) in
                if let error = error {
                    print(error)
                }
                imagesDatabaseReference.child(smallImageID)
            }
            
        }
        let largeImageID = object.largeImageID
        let imageRef = imagesStorageReference.child(largeImageID)
        imageRef.delete { (error) in
            if let error = error {
                print(error)
            }
            imagesDatabaseReference.child(largeImageID)
        }
    }    
}
