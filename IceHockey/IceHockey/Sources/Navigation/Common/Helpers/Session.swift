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
        get {
            let token = RDKeyChain.load(key: .refreshToken)
            return token != nil
        } set {
            if !newValue {
                RDKeyChain.delete(key: .refreshToken)
                RDKeyChain.delete(key: .accessToken)
            }
        }
    }
    
    static var isSeenOnboarding: Bool {
        get {
            return AppState.isSeenOnboarding.value ?? false
        } set {
            AppState.isSeenOnboarding.modify(newValue)
        }
    }
    
    static var isAppLoaded: Bool {
        get {
            return AppState.isAppStarted.value ?? false
        } set {
            AppState.isAppStarted.modify(newValue)
        }
    }
    
}
