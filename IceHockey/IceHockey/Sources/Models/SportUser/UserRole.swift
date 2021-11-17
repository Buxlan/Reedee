//
//  File.swift
//  IceHockey
//
//  Created by  Buxlan on 11/17/21.
//

import Firebase

struct UserRoleManager {
    
    enum Role {
        case readOnly
        case readWrite
    }
        
    func getRole(for user: User?, completionHandler: @escaping (Role) -> Void) {
        guard let user = user else {
            completionHandler(.readOnly)
            return
        }
        let uid = user.uid
        FirebaseManager.shared.databaseManager
            .root
            .child("moderators")
            .child(uid).getData { error, snapshot in
                guard error == nil,
                      !(snapshot.value is NSNull),
                      let value = snapshot.value as? Bool,
                      value == true else {
                          completionHandler(.readOnly)
                          return
                      }
                completionHandler(.readWrite)
            }
    }
    
}
