//
//  ApplicationUser.swift
//  IceHockey
//
//  Created by  Buxlan on 10/14/21.
//
import Firebase

struct ApplicationUser {
    var firebaseUser: User
    var sportUser: SportUser
    
    init(firebaseUser: User, sportUser: SportUser) {
        self.firebaseUser = firebaseUser
        self.sportUser = sportUser        
    }
    
}

extension ApplicationUser {
    
    var isAnonymous: Bool {
        firebaseUser.isAnonymous
    }
    
    var uid: String {
        firebaseUser.uid
    }
}
