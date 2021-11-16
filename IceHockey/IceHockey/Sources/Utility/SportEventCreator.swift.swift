//
//  SportEventCreator.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 11/6/21.
//

import Firebase

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
            object = SportNewsDatabaseFlowImpl(key: uid, dict: dict)
        case .match:
            object = MatchResult(key: uid, dict: dict)
        default:
            object = nil
        }
        
        return object
        
    }
    
}
