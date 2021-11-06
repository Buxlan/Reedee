//
//  MatchResult.swift
//  IceHockey
//
//  Created by  Buxlan on 11/4/21.
//

import Firebase

struct MatchResult: SportEvent {
    
    var uid: String
    
    var type: SportEventType
    var homeTeam: String
    var awayTeam: String
    var homeTeamScore: Int
    var awayTeamScore: Int
    
    var stadium: String
    var date: Date
    var title: String
    var status: String {
        return "Finished"
    }
    
    init?(key: String, dict: [String: Any]) {
        guard let title = dict["title"] as? String,
              let homeTeam = dict["homeTeam"] as? String,
              let awayTeam = dict["awayTeam"] as? String,
              let homeTeamScore = dict["homeTeamScore"] as? Int,
              let awayTeamScore = dict["awayTeamScore"] as? Int,
              let rawType = dict["type"] as? Int,
              let type = SportEventType(rawValue: rawType),
              let dateInterval = dict["date"] as? Int else { return nil }
                
        self.uid = key
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.homeTeamScore = homeTeamScore
        self.awayTeamScore = awayTeamScore
        self.date = Date(timeIntervalSince1970: TimeInterval(dateInterval))
        self.stadium = dict["stadium"] as? String ?? ""
        self.type = type
        self.title = title
    }
    
}

extension MatchResult {
    func setLike(_ state: Bool) {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        FirebaseManager.shared.databaseManager
            .root
            .child("likes")
            .child(self.uid).getData { error, snapshot in
                if let error = error {
                    print("Error: \(error)")
                }
                if snapshot.value is NSNull {
                    // need to create new entry
                    let dict = self.prepareLikesDict(userID: userID)
                    FirebaseManager.shared.databaseManager
                        .root
                        .child("likes")
                        .child(self.uid)
                        .setValue(dict)
                }
            }
    }
    
}
