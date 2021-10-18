//
//  DatabaseManager.swift
//  IceHockey
//
//  Created by  Buxlan on 10/6/21.
//
import Firebase

protocol FirebaseManagerInterface {
    func configure()
    var storageRootReference: StorageReference { get }
    var databaseRootReference: DatabaseReference { get }
}

struct FirebaseManager: FirebaseManagerInterface {
    
    // MARK: - Properties
    
    static let shared = FirebaseManager()
    
    private let databaseUrl = "https://icehockey-40e64-default-rtdb.europe-west1.firebasedatabase.app"
    private let storageUrl = "https://icehockey-40e64-default-rtdb.europe-west1.firebasedatabase.app"
    
    let storageRootReference: StorageReference
    let databaseRootReference: DatabaseReference
    
    // MARK: - Lifecircle
    
    private init() {
        storageRootReference = Storage.storage().reference()
        databaseRootReference = Database.database(url: databaseUrl).reference()
    }
    
    // MARK: - Helper functions
    
    func configure() {
        FirebaseApp.configure()
    }
}
