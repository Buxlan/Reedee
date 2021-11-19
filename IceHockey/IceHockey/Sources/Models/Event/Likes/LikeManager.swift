//
//  LikeManager.swift
//  IceHockey
//
//  Created by  Buxlan on 11/19/21.
//

import Firebase

struct LikeManager {
    
    func setLike(for eventID: String, newState: Bool) {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
//        let likeObject = Like(userID: userID, eventID: eventID, state: isLiked)
        let objectRef = FirebaseManager.shared.databaseManager
            .root
            .child(Like.databasePath)
            .child(eventID)
        
        if newState == true {
            let usersRef = objectRef.child("users").child(userID)
            usersRef.setValue(1)
        } else {
            let usersRef = objectRef.child("users").child(userID)
            usersRef.removeValue()
        }
    }
    
}
