//
//  LikeDatabaseFlowData.swift
//  IceHockey
//
//  Created by  Buxlan on 11/19/21.
//

import Firebase

protocol LikeDatabaseFlowData {
    static var databaseRootPath: String { get }
    var uid: String { get set }
    var count: Int { get set }
    var isLiked: Bool { get set }
}

struct DefaultLikeDatabaseFlowData: LikeDatabaseFlowData {
    static var databaseRootPath: String = "likes"
    var uid: String = ""
    var count: Int = 0
    var isLiked: Bool = false
}

struct LikeDatabaseFlowDataImpl: LikeDatabaseFlowData {
    static var databaseRootPath: String = "likes"
    var uid: String
    var count: Int
    var isLiked: Bool
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any] else { return nil }
        self.init(key: snapshot.key, dict: dict)
    }
    
    init(key: String, dict: [String: Any]) {
        // current user! Nedd to refactor this later
        let currentUserID = Auth.auth().currentUser?.uid ?? ""
        self.uid = key
        self.count = 0
        self.isLiked = false
        if let usersDict = dict["users"] as? [String: Any] {
            self.count = usersDict.count
            self.isLiked = usersDict[currentUserID] != nil
        }
    }
    
}
