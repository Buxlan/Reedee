//
//  MatchResult.swift
//  IceHockey
//
//  Created by  Buxlan on 11/4/21.
//

import UIKit

protocol MatchResult: SportEvent, MatchResultDatabaseFlowData {
    var status: MatchStatus { get }
}

struct MatchResultImpl: MatchResult {
    var likesInfo: EventLikesInfo
    var viewsInfo: EventViewsInfo
    var author: SportUser?
    
    var objectIdentifier: String {
        get { databaseFlowObject.objectIdentifier }
        set { databaseFlowObject.objectIdentifier = newValue }
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
    var status: MatchStatus {
        return MatchStatus.finished
    }
    
    var isLoading: Bool {
        return author == nil
    }
    
    private var databaseFlowObject: MatchResultDatabaseFlowData
    private var storageFlowObject: StorageFlowData
    
    init(databaseFlowObject: MatchResultDatabaseFlowData = EmptyMatchResultDatabaseFlowData(),
         storageFlowObject: StorageFlowData = EmptyStorageFlowData(),
         author: SportUser? = nil,
         likesInfo: EventLikesInfo = EventLikesInfoImpl.empty,
         viewsInfo: EventViewsInfo = EventViewsInfoImpl.empty) {
        self.databaseFlowObject = databaseFlowObject
        self.storageFlowObject = storageFlowObject
        self.likesInfo = likesInfo
        self.viewsInfo = viewsInfo
        self.author = author        
    }
    
}

extension MatchResult {
    
    func save(completionHandler: (SportEventSaveError?) -> Void) {
        MatchResultFirebaseSaver(object: self).save(completionHandler: completionHandler)
    }
    
    func encode() -> [String: Any] {
        let interval = date.timeIntervalSince1970
        let dict: [String: Any] = [
            "uid": objectIdentifier,
            "author": authorID,
            "title": title,
            "homeTeam": homeTeam,
            "awayTeam": awayTeam,
            "homeTeamScore": homeTeamScore,
            "awayTeamScore": awayTeamScore,
            "stadium": stadium,
            "type": type.rawValue,
            "date": Int(interval),
            "order": order
        ]
        return dict
    }
    
}
