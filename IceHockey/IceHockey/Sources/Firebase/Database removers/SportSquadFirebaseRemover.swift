//
//  SportSquadFirebaseRemover.swift
//  IceHockey
//
//  Created by  Buxlan on 10/29/21.
//

import Firebase

struct SportSquadFirebaseRemover: FirebaseObjectRemover {
    
    // MARK: - Properties
    
    typealias DataType = Squad
    var object: FirebaseObject
    
    internal var objectsRootDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("squads")
    }
    
    internal var objectDatabaseReference: DatabaseReference {
        objectsRootDatabaseReference.child(object.objectIdentifier)
    }
    
    internal var searchLocationDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("teams")
    }
    
    // MARK: Lifecircle
    
    // MARK: - Helper methods
    
    func remove() throws {
//        guard let object = self.object as? DataType else {
//            throw AppError.dataMismatch
//        }
//        // find references and remove
//        let query = searchLocationDatabaseReference.queryEqual(toValue: object.uid, childKey: "squads")
//        query.getData { error, snapshot in
//            if let error = error {
//                print("GetData error: \(error)")
//            }
//            guard let foundObject = SportTeam(snapshot: snapshot) else {
//                return
//            }
//            let squads = foundObject.squadIDs
//            var newSquads: [String] = []
//            squads.reversed().forEach { uid in
//                if uid != object.uid {
//                    newSquads.append(uid)
//                }
//            }
//            snapshot.setValue(newSquads, forKey: "squads")
////            foundObject.squadIDs = newSquads
////            foundObject.save()
//        }
//        objectDatabaseReference.removeValue()
    }
}
