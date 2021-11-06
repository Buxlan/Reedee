//
//  SportEvent.swift
//  IceHockey
//
//  Created by  Buxlan on 11/4/21.
//

import Foundation

protocol SportEvent {
    var uid: String { get set }
    var type: SportEventType { get set }
    init?(key: String, dict: [String: Any])
    func setLike(_ state: Bool)
    func prepareLikesDict(userID: String) -> [String: Any]
}

extension SportEvent {
    func prepareLikesDict(userID: String) -> [String: Any] {        
        let usersDict: [String: Int] = [
            userID: 1
        ]
        let dict: [String: Any] = [
            "count": 1,
            "users": usersDict
        ]
        return dict
    }
}
