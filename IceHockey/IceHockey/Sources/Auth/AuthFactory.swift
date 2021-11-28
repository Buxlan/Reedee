//
//  AuthFactory.swift
//  IceHockey
//
//  Created by  Buxlan on 11/29/21.
//

import Firebase
import FirebaseDatabase

class AuthFactory {
    
    func makeApplicationUser(firebaseUser: User,
                             completionHandler: @escaping () -> Void)
    -> ApplicationUser {
        let sportUser = FirebaseObjectFactory.shared.makeUser(with: firebaseUser.uid) {
            completionHandler()
        }
        let user = ApplicationUser(firebaseUser: firebaseUser, sportUser: sportUser)
        return user
    }
    
}
