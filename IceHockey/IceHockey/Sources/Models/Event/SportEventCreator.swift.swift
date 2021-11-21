//
//  SportEventCreator.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 11/6/21.
//

import Firebase

struct SportEventCreator {
    
    func create(snapshot: DataSnapshot,
                with completionHandler: @escaping (SportEvent?) -> Void)
    -> SportEvent? {
        
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else { return nil }
        let type = getType(dict)
        var object: SportEvent?
        
        switch type {
        case .event:
            let builder = SportNewsBuilder(key: uid, dict: dict)
            builder.build(completionHandler: completionHandler)
            object = builder.getResult()
        case .match:
            let builder = MatchResultBuilder(key: uid, dict: dict)
            builder.build(completionHandler: completionHandler)
            object = builder.getResult()
        default:
            object = nil
        }
        
        return object
        
    }
    
    private func getType(_ dict: [String: Any]) -> SportEventType? {
        guard let rawType = dict["type"] as? Int,
              let type = SportEventType(rawValue: rawType) else { return nil }
        return type
    }
    
}
