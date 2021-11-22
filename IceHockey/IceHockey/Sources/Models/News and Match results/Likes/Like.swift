//
//  Like.swift
//  IceHockey
//
//  Created by  Buxlan on 11/20/21.
//

import Foundation

struct Like {
    
    static let databasePath = "likes"
    
    let userID: String
    let eventID: String
    let state: Bool
    
    func encode() -> [String: Any] {
        let usersDict: [String: Int] = [userID: 1]
        let dict: [String: Any] = ["users": usersDict]
        return dict
    }
    
}
