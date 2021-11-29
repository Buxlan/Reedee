//
//  MatchResultProxy.swift
//  IceHockey
//
//  Created by  Buxlan on 11/24/21.
//

import Foundation

class MatchResultProxy: MatchResult {
    
    var event: MatchResult? {
        didSet {
            loadingCompletionHandler()
            loadingCompletionHandler = {}
        }
    }
    var loadingCompletionHandler: () -> Void = {}
    
    var likesInfo: EventLikesInfo {
        get { event?.likesInfo ?? EventLikesInfoImpl.empty }
        set { event?.likesInfo = newValue }
    }
    var viewsInfo: EventViewsInfo {
        get { event?.viewsInfo ?? EventViewsInfoImpl.empty }
        set { event?.viewsInfo = newValue }
    }
    
    var objectIdentifier: String {
        get { event?.objectIdentifier ?? "" }
        set { event?.objectIdentifier = newValue }
    }
    var authorID: String {
        get { event?.authorID ?? "" }
        set { event?.authorID = newValue }
    }
    var author: SportUser? {
        get { event?.author }
        set { event?.author = newValue }
    }
    var type: SportEventType {
        get { event?.type ?? .match }
        set { event?.type = newValue }
    }
    var homeTeam: String {
        get { event?.homeTeam ?? "" }
        set { event?.homeTeam = newValue }
    }
    var awayTeam: String {
        get { event?.awayTeam ?? "" }
        set { event?.awayTeam = newValue }
    }
    var homeTeamScore: Int {
        get { event?.homeTeamScore ?? 0 }
        set { event?.homeTeamScore = newValue }
    }
    var awayTeamScore: Int {
        get { event?.awayTeamScore ?? 0 }
        set { event?.awayTeamScore = newValue }
    }
    var stadium: String {
        get { event?.stadium ?? "" }
        set { event?.stadium = newValue }
    }
    var date: Date {
        get { event?.date ?? Date() }
        set { event?.date = newValue }
    }
    var title: String {
        get { event?.title ?? "" }
        set { event?.title = newValue }
    }
    var text: String {
        get { event?.text ?? "" }
        set { event?.text = newValue }
    }
    var order: Int {
        get { event?.order ?? 0 }
        set { event?.order = newValue }
    }
    var status: MatchStatus {
        return event?.status ?? .finished
    }
    
    var isLoading: Bool {
        return event == nil
    }
    
}

extension MatchResultProxy {
    
    func save(completionHandler: @escaping (SportEventSaveError?) -> Void) {
        event?.save(completionHandler: completionHandler)
    }
    
    func delete(completionHandler: @escaping (FirebaseRemoveError?) -> Void) {
        event?.delete(completionHandler: completionHandler)
    }
    
    func encode() -> [String : Any] {
        if let event = event {
            return event.encode()
        } else {
            return [:]
        }
    }
    
}
