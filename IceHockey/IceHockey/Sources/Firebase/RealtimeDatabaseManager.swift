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
    
    func getEventLikeInfo(eventID: String, completionHandler: @escaping (Int, Bool) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        if eventID.isEmpty {
            completionHandler(0, false)
            return
        }
        FirebaseManager.shared.databaseManager
            .root.child("likes")
            .child(eventID)
            .getData { error, snapshot in
                guard error == nil,
                      !(snapshot.value is NSNull),
                      let dict = snapshot.value as? [String: Any],
                      let count = dict["count"] as? Int,
                      let users = dict["users"] as? [String: Int] else {
                    completionHandler(0, false)
                    return
                }
                // entity exists
                let userLikes = (users[userID] != nil)
                completionHandler(count, userLikes)                
            }
    }
    
}
