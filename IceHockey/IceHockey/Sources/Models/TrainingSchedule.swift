//
//  TrainingSchedule.swift
//  IceHockey
//
//  Created by  Buxlan on 11/10/21.
//

import Firebase

struct TrainingSchedule {
    
    


enum DayOfWeek: Int, CustomStringConvertible, RawRepresentable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
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

struct TrainingSchedule: Codable, FirebaseObject {
    
    var uid: String
    
    var author: String
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
         order: Int = 0,
         author: String = "") {
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
        self.author = author
    }
    
    init?(key: String, dict: [String: Any]) {
        guard let title = dict["title"] as? String,
              let author = dict["author"] as? String,
              let homeTeam = dict["homeTeam"] as? String,
              let awayTeam = dict["awayTeam"] as? String,
              let homeTeamScore = dict["homeTeamScore"] as? Int,
              let awayTeamScore = dict["awayTeamScore"] as? Int,
              let rawType = dict["type"] as? Int,
              let type = SportEventType(rawValue: rawType),
              let dateInterval = dict["date"] as? Int,
              let order = dict["order"] as? Int else { return nil }
                
        self.uid = key
        self.author = author
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
    
    static func getObject(by uid: String, completionHandler handler: @escaping (MatchResult?) -> Void) {
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
            try ExistingMatchResultFirebaseSaver(object: self).save()
        } else {
            try NewMatchResultFirebaseSaver(object: self).save()
        }
    }
    
    func prepareDataForSaving() -> [String: Any] {
        let interval = self.date.timeIntervalSince1970
        let dict: [String: Any] = [
            "uid": self.uid,
            "author": self.author,
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

