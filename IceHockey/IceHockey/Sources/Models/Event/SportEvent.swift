//
//  SportEvent.swift
//  IceHockey
//
//  Created by  Buxlan on 11/4/21.
//

import Firebase

protocol SportEvent: FirebaseObject {
    var type: SportEventType { get set }
    var date: Date { get set }
    var authorID: String { get set }
    var isNew: Bool { get }
    var order: Int { get set }
    var title: String { get set }
    var text: String { get set }
    
    var author: SportUser? { get set }
    var likesInfo: EventLikesInfo { get set }
    var viewsInfo: EventViewsInfo { get set }    
}

extension SportEvent {
    
    var isNew: Bool {
        return uid.isEmpty
    }
    
    func prepareLikesDict(userID: String) -> [String: Any] {        
        let usersDict: [String: Int] = [
            userID: 1
        ]
        let dict: [String: Any] = [
            "count": 1,
            "users": usersDict
        ]
        return dict
    }
    
    func setLike(_ state: Bool) {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let objectRef = FirebaseManager.shared.databaseManager.root
            .child("likes")
            .child(self.uid)
        let countRef = objectRef.child("count")
        countRef.getData { error, snapshot in
            if let error = error {
                print("Error: \(error)")
                return
            }
            if snapshot.value is NSNull {
                // need to create new entry in database
                if state == true {
                    let dict = self.prepareLikesDict(userID: userID)
                    objectRef.setValue(dict)
                    return
                }
            }
            guard let count = snapshot.value as? Int else {
                return
            }
            if state == true {
                countRef.setValue(count + 1)
                let usersRef = objectRef.child("users").child(userID)
                usersRef.setValue(1)
            } else {
                countRef.setValue(count - 1)
                let usersRef = objectRef.child("users").child(userID)
                usersRef.removeValue()
            }
        }
    }
}
