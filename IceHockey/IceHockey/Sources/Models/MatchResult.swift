//
//  MatchResult.swift
//  IceHockey
//
//  Created by  Buxlan on 11/4/21.
//

import Firebase

enum MatchStatus: Int, CustomStringConvertible {
    case planned
    case inProgress
    case finished
    
    var description: String {
        switch self {
        case .planned:
            return L10n.MatchStatus.plannedTitle
        case .inProgress:
            return L10n.MatchStatus.inProgressTitle
        case .finished:
            return L10n.MatchStatus.finishedTitle
        }
    }
}

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
        return MatchStatus.finished.description
    }
    
    init(uid: String = "",
         title: String = "",
         homeTeam: String = "",
         awayTeam: String = "",
         homeTeamScore: Int = 0,
         awayTeamScore: Int = 0,
         date: Date = Date(),
         stadium: String = "") {
        self.uid = uid
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.homeTeamScore = homeTeamScore
        self.awayTeamScore = awayTeamScore
        self.date = date
        self.stadium = ""
        self.type = .match
        self.title = title
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
