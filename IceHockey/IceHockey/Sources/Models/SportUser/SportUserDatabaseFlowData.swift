//
//  SportUserDatabaseFlowData.swift
//  IceHockey
//
//  Created by  Buxlan on 11/17/21.
//

import Firebase

protocol SportUserDatabaseFlowData {
    var uid: String { get set }
    var imageID: String { get set }
    var displayName: String { get set }
}

struct SportUserDatabaseFlowDataImpl: SportUserDatabaseFlowData {
    var uid: String
    var imageID: String
    var displayName: String
    
    init(uid: String,
         displayName: String,
         imageID: String) {
        self.uid = uid
        self.imageID = imageID
        self.displayName = displayName
    }
    
    internal init() {
        self.uid = ""
        self.imageID = ""
        self.displayName = ""
    }
    
    init?(key: String, dict: [String: Any]) {
        guard let imageID = dict["image"] as? String,
              let displayName = dict["displayName"] as? String
        else { return nil }
                
        self.uid = key
        self.imageID = imageID
        self.displayName = displayName
    }
    
    init?(snapshot: DataSnapshot) {
        guard !(snapshot.value is NSNull),
              let dict = snapshot.value as? [String: Any] else {
                  return nil
              }
        self.init(key: snapshot.key, dict: dict)
    }
    
}
