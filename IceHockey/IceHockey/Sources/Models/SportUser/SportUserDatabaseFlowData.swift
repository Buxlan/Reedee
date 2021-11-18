//
//  SportUserDatabaseFlowData.swift
//  IceHockey
//
//  Created by  Buxlan on 11/17/21.
//

import Firebase

protocol SportUserDatabaseFlowData: SportUserObject {    
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
    
    init(key: String, dict: [String: Any]) {                
        self.uid = key
        self.imageID = dict["image"] as? String ?? ""
        self.displayName = dict["displayName"] as? String ?? ""
    }
    
    init?(snapshot: DataSnapshot) {
        guard !(snapshot.value is NSNull),
              let dict = snapshot.value as? [String: Any] else {
                  return nil
              }
        self.init(key: snapshot.key, dict: dict)
    }
    
}
