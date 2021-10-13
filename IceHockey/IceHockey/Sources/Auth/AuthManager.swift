//
//  AuthManager.swift
//  IceHockey
//
//  Created by  Buxlan on 10/6/21.
//

import Firebase

class AuthManager {
    
    var currentUser: ApplicationUser?
    private lazy var authStateListener: (Auth, User?) -> Void = { [weak self] (_, user) in
        guard let self = self else {
            return
        }
        self.currentUser?.user = user
    }
    
    func signInAnonymously() {
        Auth.auth().signInAnonymously { (authResult, error) in
            if let error = error {
                print(error)
                return
            }
            guard let _ = authResult?.user else {
                print("Succesfully signed")
                return
            }
            self.currentUser = ApplicationUser()
            Auth.auth().addStateDidChangeListener(self.authStateListener)
        }
    }
    
    
    
}