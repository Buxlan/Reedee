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
    var headCoach: SportCoach?
    var players: [SportPlayer]
    
    // MARK: - Lifecircle
    
    init?(snapshot: DataSnapshot) {
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else { return nil }
        guard let displayName = dict["displayName"] as? String else { return nil }
        guard let headCoach = dict["headCoach"] as? SportCoach else { return nil }
        guard let players = dict["players"] as? [SportPlayer] else { return nil }
                
        self.uid = uid
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
