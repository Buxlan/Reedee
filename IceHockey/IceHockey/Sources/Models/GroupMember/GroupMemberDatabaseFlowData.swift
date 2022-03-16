//
//  GroupMemberDatabaseFlowData.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 17.03.2022.
//

import Firebase

protocol GroupMemberDatabaseFlowData: SnapshotInitiable, FirebaseObject {
    var name: String { get set }
    var surname: String { get set }
    var number: String { get set }
    var parentUserId: String { get set }
    init?(snapshot: DataSnapshot)
}

struct GroupMemberDatabaseFlowDataImpl: GroupMemberDatabaseFlowData {
    
    static let empty = Self()
    
    var objectIdentifier: String
    var name: String
    var surname: String
    var number: String
    var parentUserId: String
    
    init() {
        objectIdentifier = ""
        name = ""
        surname = ""
        number = ""
        parentUserId = ""
    }
        
    init?(snapshot: DataSnapshot) {
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else {
            return nil
        }
        self.init(key: uid, dict: dict)
    }
    
    init(key: String, dict: [String: Any]) {
        self.objectIdentifier = key
        self.name = dict["name"] as? String ?? ""
        self.surname = dict["surname"] as? String ?? ""
        self.number = dict["number"] as? String ?? ""
        self.parentUserId = dict["parentUserId"] as? String ?? ""
    }
    
}

