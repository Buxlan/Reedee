//
//  SportNewsObjectManager.swift
//  IceHockey
//
//  Created by  Buxlan on 11/14/21.
//

import Firebase

struct SportNewsObjectManager {
    
    typealias DataType = SportNews
    
    private static var databaseObjects: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("events")
    }
    
    func makeObject(with uid: String,
                    completionHandler handler: @escaping (DataType?) -> Void) {
        Self.databaseObjects
            .child(uid)
            .getData { error, snapshot in
                if let error = error {
                    print(error)
                    return
                }
                if snapshot.value is NSNull {
                    fatalError("Current team is nil")
                }
                let object = makeObject(snapshot: snapshot)
                handler(object)
            }
    }
    
    func makeObject(snapshot: DataSnapshot) -> DataType? {
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else {
            return nil
        }
        let object = SportNews(key: uid, dict: dict)
        return object
    }
    
    func delete() throws {
        try FirebaseManager.shared.delete(object)
    }
    
    func checkProperties() -> Bool {
        return true
    }
    
    func save(object: DataType) throws {
        if !checkProperties() {
            print("Error. Properties are wrong")
        }
        try SportNewsFirebaseSaver(object: object).save()
    }
    
}
