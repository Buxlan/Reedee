//
//  ProfileViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 11/5/21.
//

import Firebase

enum Setting: CustomStringConvertible {
    case signIn
    case signUp
    case signOut
    case addEvent
    
    var description: String {
        switch self {
        case .signIn:
            return "Sign in"
        case .signOut:
            return "Sign out"
        case .signUp:
            return "Sign up"
        case .addEvent:
            return "Add new event"
        }
    }
    
    var hasDisclosure: Bool {
        switch self {
        case .addEvent:
            return true
        default:
            return false
        }
    }
    
}
