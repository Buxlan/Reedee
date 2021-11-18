//
//  MatchResult.swift
//  IceHockey
//
//  Created by  Buxlan on 11/4/21.
//

import UIKit

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

struct MatchResult: MatchResultDatabaseFlowData {
    var likesInfo: EventLikesInfo
    var viewsInfo: EventViewsInfo
    
    var uid: String {
        get { databaseFlowObject.uid }
        set { databaseFlowObject.uid = newValue }
    }
    var authorID: String {
        get { databaseFlowObject.authorID }
        set { databaseFlowObject.authorID = newValue }
    }
    var type: SportEventType {
        get { databaseFlowObject.type }
        set { databaseFlowObject.type = newValue }
    }
    var homeTeam: String {
        get { databaseFlowObject.homeTeam }
        set { databaseFlowObject.homeTeam = newValue }
    }
    var awayTeam: String {
        get { databaseFlowObject.awayTeam }
        set { databaseFlowObject.awayTeam = newValue }
    }
    var homeTeamScore: Int {
        get { databaseFlowObject.homeTeamScore }
        set { databaseFlowObject.homeTeamScore = newValue }
    }
    var awayTeamScore: Int {
        get { databaseFlowObject.awayTeamScore }
        set { databaseFlowObject.awayTeamScore = newValue }
    }
    var stadium: String {
        get { databaseFlowObject.stadium }
        set { databaseFlowObject.stadium = newValue }
    }
    var date: Date {
        get { databaseFlowObject.date }
        set { databaseFlowObject.date = newValue }
    }
    var title: String {
        get { databaseFlowObject.title }
        set { databaseFlowObject.title = newValue }
    }
    var text: String {
        get { databaseFlowObject.text }
        set { databaseFlowObject.text = newValue }
    }
    var order: Int {
        get { databaseFlowObject.order }
        set { databaseFlowObject.order = newValue }
    }
    var status: String {
        return MatchStatus.finished.description
    }
    
    var author: SportUser?
    
    private var databaseFlowObject: MatchResultDatabaseFlowData
    private var storageFlowObject: MatchResultStorageFlowData
    
    init(databaseFlowObject: MatchResultDatabaseFlowData = DefaultMatchResultDatabaseFlowData(),
         storageFlowObject: MatchResultStorageFlowData = DefaultMatchResultStorageFlowData(),
         author: SportUser? = nil) {
        self.databaseFlowObject = databaseFlowObject
        self.storageFlowObject = storageFlowObject
        self.likesInfo = EventLikesInfo()
        self.viewsInfo = EventViewsInfo()
        self.author = author        
    }
    
}

//extension MatchResult: FirebaseObject {
//
//    private static var databaseObjects: DatabaseReference {
//        FirebaseManager.shared.databaseManager.root.child("events")
//    }
//
//    var isNew: Bool {
//        return self.uid.isEmpty
//    }
//
//    func delete() throws {
//        try FirebaseManager.shared.delete(self)
//    }
//
//    func checkProperties() -> Bool {
//        return true
//    }
//
//    func save() throws {
//
//        if !checkProperties() {
//            print("Error. Properties are wrong")
//        }
//
//        if isNew {
//            try ExistingMatchResultFirebaseSaver(object: self).save()
//        } else {
//            try NewMatchResultFirebaseSaver(object: self).save()
//        }
//    }
//
//    func prepareDataForSaving() -> [String: Any] {
//        let interval = self.date.timeIntervalSince1970
//        let dict: [String: Any] = [
//            "uid": self.uid,
//            "author": self.author,
//            "title": self.title,
//            "homeTeam": self.homeTeam,
//            "awayTeam": self.awayTeam,
//            "homeTeamScore": self.homeTeamScore,
//            "awayTeamScore": self.awayTeamScore,
//            "stadium": self.stadium,
//            "type": self.type.rawValue,
//            "date": Int(interval),
//            "order": Int(order)
//        ]
//        return dict
//    }
//
//}
