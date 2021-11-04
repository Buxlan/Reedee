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

protocol SportEventCreator {
    
    func create(snapshot: DataSnapshot) -> SportEvent?
    
}

struct SportEventCreatorImpl {
    
    func create(snapshot: DataSnapshot) -> SportEvent? {
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else { return nil }
        guard let rawType = dict["type"] as? Int,
              let type = SportEventType(rawValue: rawType) else { return nil }
        
        var object: SportEvent?
        switch type {
        case .event:
            object = SportNews(key: uid, dict: dict)
        case .match:
            object = MatchResult(key: uid, dict: dict)
        default:
            object = nil
        }
        
        return object
        
    }
    
}
