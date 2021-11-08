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
    var order: Int
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
         stadium: String = "",
         order: Int = 0) {
        self.uid = uid
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.homeTeamScore = homeTeamScore
        self.awayTeamScore = awayTeamScore
        self.date = date
        self.stadium = ""
        self.type = .match
        self.title = title
        self.order = order
    }
    
    init?(key: String, dict: [String: Any]) {
        guard let title = dict["title"] as? String,
              let homeTeam = dict["homeTeam"] as? String,
              let awayTeam = dict["awayTeam"] as? String,
              let homeTeamScore = dict["homeTeamScore"] as? Int,
              let awayTeamScore = dict["awayTeamScore"] as? Int,
              let rawType = dict["type"] as? Int,
              let type = SportEventType(rawValue: rawType),
              let dateInterval = dict["date"] as? Int,
              let order = dict["order"] as? Int else { return nil }
                
        self.uid = key
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.homeTeamScore = homeTeamScore
        self.awayTeamScore = awayTeamScore
        self.date = Date(timeIntervalSince1970: TimeInterval(dateInterval))
        self.stadium = dict["stadium"] as? String ?? ""
        self.type = type
        self.title = title
        self.order = order
    }
    
    init?(snapshot: DataSnapshot) {
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else {
            return nil
        }
        self.init(key: uid, dict: dict)
    }
    
}

extension MatchResult: FirebaseObject {
    
    private static var databaseObjects: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("events")
    }
    
    static func getObject(by uid: String, completion handler: @escaping (MatchResult?) -> Void) {
        Self.databaseObjects
            .child(uid)
            .getData { error, snapshot in
                if let error = error {
                    print(error)
                    return
                }
                if snapshot.value is NSNull {
                    fatalError("Current team is nil")
                }
                let team = Self(snapshot: snapshot)
                handler(team)
            }
    }
    
    func delete() throws {
        try FirebaseManager.shared.delete(self)
    }
        
    var isNew: Bool {
        return self.uid.isEmpty
    }
    
    func checkProperties() -> Bool {
        return true
    }
    
    func save() throws {
        
        if !checkProperties() {
            print("Error. Properties are wrong")
        }
        
        if isNew {
            try ExistingMatchResultFirebaseSaver(object: self).save {
                print("!!!existing ok!!!")
            }
        } else {
            try NewMatchResultFirebaseSaver(object: self).save {
                print("!!!new ok!!!")
            }
        }
    }
    
    func prepareDataForSaving() -> [String: Any] {
        let interval = self.date.timeIntervalSince1970
        let dict: [String: Any] = [
            "uid": self.uid,
            "title": self.title,
            "homeTeam": self.homeTeam,
            "awayTeam": self.awayTeam,
            "homeTeamScore": self.homeTeamScore,
            "awayTeamScore": self.awayTeamScore,
            "stadium": self.stadium,
            "type": self.type.rawValue,
            "date": Int(interval),
            "order": Int(order)
        ]
        return dict
    }
    
}
