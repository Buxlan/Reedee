//
//  ApplicationUser.swift
//  IceHockey
//
//  Created by  Buxlan on 10/14/21.
//
import Firebase

struct ApplicationUser {
    var firebaseUser: User?
}

extension ApplicationUser {
    var user: User? {
        get {
            firebaseUser
        }
        set {
            firebaseUser = newValue
        }
    }
    
    var isAnonymous: Bool {
        firebaseUser?.isAnonymous ?? true
    }
    
    var uid: String? {
        firebaseUser?.uid ?? ""
    }
}
