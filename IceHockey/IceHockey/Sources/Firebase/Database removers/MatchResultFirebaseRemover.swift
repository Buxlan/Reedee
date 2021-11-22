//
//  MatchResultFirebaseRemover.swift
//  IceHockey
//
//  Created by  Buxlan on 11/9/21.
//

import Firebase

struct MatchResultFirebaseRemover: FirebaseObjectRemover {
    
    // MARK: - Properties
    
    typealias DataType = MatchResult
    var object: FirebaseObject
    
    internal var objectsRootDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("events")
    }
    
    internal var objectDatabaseReference: DatabaseReference {
        objectsRootDatabaseReference.child(object.objectIdentifier)
    }
    
    // MARK: Lifecircle
    
    // MARK: - Helper methods
    
    func remove() throws {
        guard let _ = self.object as? DataType else {
            throw FirebaseRemoveError.dataMismatch
        }
        objectDatabaseReference.removeValue()
    }
}
