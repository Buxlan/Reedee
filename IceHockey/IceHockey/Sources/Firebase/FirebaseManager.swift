//
//  DatabaseManager.swift
//  IceHockey
//
//  Created by  Buxlan on 10/6/21.
//
import Firebase

protocol FirebaseManagerInterface {
    func configureFirebase()
}

struct FirebaseManager: FirebaseManagerInterface {
    
    // MARK: - Properties
    
    static let shared = FirebaseManager()
    
    let databaseManager = RealtimeDatabaseManager()
    let storageManager = FirebaseStorageManager()
    
    // MARK: - Lifecircle
    
    // MARK: - Helper functions
    
    func configureFirebase() {
        FirebaseApp.configure()
    }
    
    func delete(_ object: FirebaseObject) throws {
        if let object = object as? SportTeam {
            try SportTeamFirebaseRemover(object: object).remove()
        } else if let object = object as? SportSquad {
            try SportSquadFirebaseRemover(object: object).remove()
        } else if let object = object as? SportNews {
            try SportNewsFirebaseRemover(object: object).remove()
        } else if let object = object as? MatchResult {
            try MatchResultFirebaseRemover(object: object).remove()
        } else if let object = object as? SportUser {
            throw FirebaseRemoveError.notImplemented
        }
    }
    
}
