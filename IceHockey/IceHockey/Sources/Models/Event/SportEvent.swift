//
//  SportEvent.swift
//  IceHockey
//
//  Created by  Buxlan on 11/4/21.
//

import Firebase

protocol SportEvent: FirebaseObject {
    var type: SportEventType { get set }
    var date: Date { get set }
    var authorID: String { get set }
    var isNew: Bool { get }
    var order: Int { get set }
    var title: String { get set }
    var text: String { get set }
    
    var author: SportUser? { get set }
    var likesInfo: EventLikesInfo { get set }
    var viewsInfo: EventViewsInfo { get set }    
}

extension SportEvent {
    
    var isNew: Bool {
        return uid.isEmpty
    }
    
}
