//
//  RealtimeDatabaseManager.swift
//  IceHockey
//
//  Created by  Buxlan on 10/22/21.
//

import Firebase

struct RealtimeDatabaseManager {
    
    // MARK: - Properties
    
    private let databaseUrlKey: String = "databaseURL"
    private let databaseUrl: String
    let root: DatabaseReference
    
    init() {
        if let databaseUrl = Bundle.main.object(forInfoDictionaryKey: databaseUrlKey) as? String {
            self.databaseUrl = databaseUrl
            root = Database.database(url: databaseUrl).reference()
        } else {
            self.databaseUrl = ""
            root = Database.database().reference()
        }
    }   
}

extension RealtimeDatabaseManager {
    
    func getNewImageUID() -> String? {
        let key = root.child("images").childByAutoId().key
        return key
    }
    
    func getEventIsLiked(eventID: String, completionHandler: @escaping (Bool) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completionHandler(false)
            return
        }
        FirebaseManager.shared.databaseManager
            .root.child("likes")
            .child(eventID)
            .child("users")
            .getData { error, snapshot in
                guard error == nil,
                      !(snapshot.value is NSNull),
                      let users = snapshot.value as? [String] else {
                          completionHandler(false)
                          return
                      }
                if users.firstIndex(of: userID) != nil {
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
            }
    }
    
    func getEventLikeCount(eventID: String, completionHandler: @escaping (Int) -> Void) {
        FirebaseManager.shared.databaseManager
            .root.child("likes")
            .child(eventID)
            .child("count")
            .getData { error, snapshot in
                guard error == nil,
                      !(snapshot.value is NSNull),
                      let count = snapshot.value as? Int else {
                          completionHandler(0)
                          return
                      }
                completionHandler(count)
            }
    }
    
}
