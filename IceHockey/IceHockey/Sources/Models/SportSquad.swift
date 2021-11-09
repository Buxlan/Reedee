//
//  HockeySquad.swift
//  IceHockey
//
//  Created by  Buxlan on 9/5/21.
//

import Firebase

struct SportSquad: FirebaseObject, Codable {
        
    // MARK: - Properties
    
    var uid: String
    var displayName: String
    var headCoach: String
    var players: [String]
    
    // MARK: - Lifecircle
    
    init?(snapshot: DataSnapshot) {
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else { return nil }
        self.init(key: uid, dict: dict)
    }
    
    init?(key: String, dict: [String: Any]) {
        guard let displayName = dict["name"] as? String,
              let headCoach = dict["headCoach"] as? String,
              let players = dict["players"] as? [String] else { return nil }
                
        self.uid = key
        self.displayName = displayName
        self.headCoach = headCoach
        self.players = players
    }
    
    // MARK: - Helper methods
    
    func save() throws {
        
    }
    
    func delete() throws {
        try FirebaseManager.shared.delete(self)
    }
    
    static func getObject(by uid: String, completionHandler handler: @escaping (SportSquad?) -> Void) {
        
    }
    
}
