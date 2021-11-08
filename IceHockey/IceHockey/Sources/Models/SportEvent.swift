//
//  SportEvent.swift
//  IceHockey
//
//  Created by  Buxlan on 11/4/21.
//

import Firebase

enum SportEventSaveError: LocalizedError {
    case wrongProperties
    case wrongInput
    
    var errorDescription: String? {
        switch self {
        case .wrongProperties:
            return "Not every properties is defined"
        case .wrongInput:
            return "Wrong type of input data"
        }
    }
}

protocol SportEvent {
    
    // MARK: - Properties
    var uid: String { get set }
    var type: SportEventType { get set }
    var date: Date { get set }
    var isNew: Bool { get }
    var order: Int { get set }
    
    // MARK: - Lifecircle
    init?(key: String, dict: [String: Any])
    
    // MARK: - Helper methods
    func setLike(_ state: Bool)
    func prepareLikesDict(userID: String) -> [String: Any]
    func save() throws
    func prepareDataForSaving() -> [String: Any]
}

extension SportEvent {
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
