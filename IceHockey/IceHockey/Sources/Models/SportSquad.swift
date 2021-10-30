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
        self.init(key: uid, dict: dict as NSDictionary)
    }
    
    init?(key: String, dict: NSDictionary) {
        guard let displayName = dict["name"] as? String else { return nil }
        guard let headCoach = dict["headCoach"] as? String else { return nil }
        guard let players = dict["players"] as? [String] else { return nil }
                
        self.uid = key
        self.displayName = displayName
        self.headCoach = headCoach
        self.players = players
    }
    
    // MARK: - Helper methods
    
    func delete() {
        do {
            try FirebaseManager.shared.delete(self)
        } catch AppError.dataMismatch {
            print("Data mismatch")
        } catch {
            print("Some other error")
        }
    }
    
}
