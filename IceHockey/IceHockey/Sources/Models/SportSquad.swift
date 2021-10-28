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
    
    var strikers: [SportPlayer] = [
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 1),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 2),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 3),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 4),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 5),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 6),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 7)
    ]
    var defenders: [SportPlayer] = [
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 11),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 12),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 13),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 14),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 15),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 16),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 17),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 18),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 19)
    ]
    
    var goalkeepers: [SportPlayer] = [
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .goalkeeper, gameNumber: 1),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .goalkeeper, gameNumber: 2)
    ]
    
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
