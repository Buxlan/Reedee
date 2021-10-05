//
//  AuthManager.swift
//  IceHockey
//
//  Created by  Buxlan on 10/6/21.
//

import Firebase

struct AuthManager {    
    func signInAnonymously() {
        Auth.auth().signInAnonymously { (authResult, error) in
            
            guard let user = authResult?.user else { return }
            let isAnonymous = user.isAnonymous  // true
            let uid = user.uid
        }
    }
    
}
