//
//  UserDefaultsWrapper.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.03.2022.
//

import Foundation

struct UserDefaultsWrapper {
    
    fileprivate static let userDefaultsStandart = UserDefaults.standard
    
    static var isSeenOnboarding: Bool {
        get {
            return userDefaultsStandart.bool(forKey: PersistantKeys.isSeenOnboarding)
        }
        set {
            userDefaultsStandart.set(newValue, forKey: PersistantKeys.isSeenOnboarding)
        }
    }
    
    static var token: String? {
        get {
            return userDefaultsStandart.string(forKey: PersistantKeys.token)
        }
        set {
            userDefaultsStandart.set(newValue, forKey: PersistantKeys.token)
        }
    }
    
    static var isAppLoaded: Bool {
        get {
            return userDefaultsStandart.bool(forKey: PersistantKeys.isAppLoaded)
        }
        set {
            userDefaultsStandart.set(newValue, forKey: PersistantKeys.isAppLoaded)
        }
    }
    
}
