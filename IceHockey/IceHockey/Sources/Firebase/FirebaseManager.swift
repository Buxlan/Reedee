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
            let remover = SportTeamFirebaseRemover(object: object)
            try remover.remove {
                print("!!!removed!!!")
            }
        } else if let object = object as? SportSquad {
            let remover = SportSquadFirebaseRemover(object: object)
            try remover.remove {
                print("!!!removed!!!")
            }
        }
    }
    
}
