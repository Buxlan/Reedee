//
//  SportEvent.swift
//  IceHockey
//
//  Created by  Buxlan on 11/4/21.
//

import Foundation
import UIKit

protocol Event: FirebaseObject {
    var type: SportEventType { get set }
    var date: Date { get set }
    var authorID: String { get set }
    var order: Int { get set }
    var title: String { get set }
    var text: String { get set }
}

protocol SportEvent: Event {
    var author: SportUser? { get set }
    var likesInfo: EventLikesInfo { get set }
    var viewsInfo: EventViewsInfo { get set }
    
    func save(completionHandler: (SportEventSaveError?) -> Void)
    func encode() -> [String: Any]
}

extension SportEvent {
    var isLoading: Bool {
        return false
    }
    var isNew: Bool {
        return objectIdentifier.isEmpty
    }
}
