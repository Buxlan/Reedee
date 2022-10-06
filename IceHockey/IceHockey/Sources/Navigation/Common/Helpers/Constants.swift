//
//  Constants.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 19.03.2022.
//

// MARK: - Typealiases
typealias CompletionBlock = () -> Void
typealias AlertCompletionBlock = (String) -> Void

enum PersistantKeys {
    
    static let isSeenOnboarding = "kIsSeenOnboarding"
    static let token = "kToken"
    static let isAppLoaded = "kIsAppLoaded"
    
}
