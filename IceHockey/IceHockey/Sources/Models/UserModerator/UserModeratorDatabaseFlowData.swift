//
//  UserModeratorDatabaseFlowData.swift
//  IceHockey
//
//  Created by  Buxlan on 11/17/21.
//

protocol UserModeratorDatabaseFlowData {
    var uid: String { get set }
    var imageID: String { get set }
}

struct UserModeratorDatabaseFlowDataImpl: UserModeratorDatabaseFlowData {
    var uid: String
    var imageID: String
    
    init(uid: String,
         imageID: String) {
        self.uid = uid
        self.imageID = imageID
    }
    
    internal init() {
        self.uid = ""
        self.imageID = ""
    }
    
    init?(key: String, dict: [String: Any]) {
        guard let imageID = dict["imageID"] as? String
        else { return nil }
                
        self.uid = key
        self.imageID = imageID
    }
    
}

