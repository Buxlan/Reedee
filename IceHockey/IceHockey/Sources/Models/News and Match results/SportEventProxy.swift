//
//  SportEventProxy.swift
//  IceHockey
//
//  Created by  Buxlan on 11/23/21.
//

import Foundation

class SportEventProxy: SportEvent {
    
    var event: SportEvent?
    
    var objectIdentifier: String {
        get { event?.objectIdentifier ?? "" }
        set { event?.objectIdentifier = newValue }
    }
    var type: SportEventType {
        get { event?.type ?? .event }
        set { event?.type = newValue }
    }
    var date: Date {
        get { event?.date ?? Date() }
        set { event?.date = newValue }
    }
    var authorID: String {
        get { event?.authorID ?? "" }
        set { event?.authorID = newValue }
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
    var author: SportUser? {
        get { event?.author }
        set { event?.author = newValue }
    }
    var likesInfo: EventLikesInfo {
        get { event?.likesInfo ?? EventLikesInfoImpl.empty }
        set { event?.likesInfo = newValue }
    }
    
    var viewsInfo: EventViewsInfo {
        get { event?.viewsInfo ?? EventViewsInfoImpl.empty }
        set { event?.viewsInfo = newValue }
    }
    
    var isLoading: Bool {
        event == nil
    }
    
}

extension SportEventProxy {
    
    func save(completionHandler: @escaping (SaveObjectError?) -> Void) {
        event?.save(completionHandler: completionHandler)
    }
    
    func delete(completionHandler: @escaping (FirebaseRemoveError?) -> Void) {
        event?.delete(completionHandler: completionHandler)
    }
    
    func encode() -> [String: Any] {
        if let event = event {
            return event.encode()
        } else {
            return [:]
        }
    }
    
}
