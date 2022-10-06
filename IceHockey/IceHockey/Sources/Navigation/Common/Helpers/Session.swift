//
//  Session.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.03.2022.
//

import Foundation

typealias Credentials = (username: String, password: String)

struct Session {
    static var isAuthorized: Bool {
        return RDKeyChain.load(key: .loginToken) != nil
    }
    
    static var isSeenOnboarding: Bool {
        get {
            return AppState.isSeenOnboarding.value ?? false
        }
        set {
            AppState.isSeenOnboarding.modify(newValue)
        }
    }
    
    static var isAppLoaded: Bool {
        get {
            return AppState.isAppStarted.value ?? false
        }
        set {
            AppState.isAppStarted.modify(newValue)
        }
    }
    
}
