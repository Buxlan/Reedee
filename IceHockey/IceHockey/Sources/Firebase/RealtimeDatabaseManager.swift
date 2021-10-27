//
//  RealtimeDatabaseManager.swift
//  IceHockey
//
//  Created by  Buxlan on 10/22/21.
//

import Firebase

struct RealtimeDatabaseManager {
    
    // MARK: - Properties
    
    private let databaseUrlKey: String = "databaseURL"
    private let databaseUrl: String
    let root: DatabaseReference
    
    init() {
        if let databaseUrl = Bundle.main.object(forInfoDictionaryKey: databaseUrlKey) as? String {
            self.databaseUrl = databaseUrl
            root = Database.database(url: databaseUrl).reference()
        } else {
            self.databaseUrl = ""
            root = Database.database().reference()
        }
    }   
}

extension RealtimeDatabaseManager {
    
    func getNewImageUID() -> String? {
        let key = root.child("images").childByAutoId().key
        print("Got key: \(key)")
        return key
    }
    
}
