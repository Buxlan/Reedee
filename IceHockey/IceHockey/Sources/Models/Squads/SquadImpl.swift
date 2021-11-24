//
//  ClubImpl.swift
//  IceHockey
//
//  Created by  Buxlan on 11/23/21.
//

import Foundation

struct SquadImpl: Squad {
        
    // MARK: - Properties
    
    var objectIdentifier: String
    var displayName: String
    var headCoach: String
    
    // MARK: - Lifecircle
        
    init(databaseData: SquadDatabaseFlowData,
         storageData: StorageFlowData) {
        self.objectIdentifier = databaseData.objectIdentifier
        self.displayName = databaseData.displayName
        self.headCoach = databaseData.headCoach        
    }
    
    // MARK: - Helper methods
    
    func encode() -> [String: Any] {
        var dict: [String: Any] = [
            "uid": self.objectIdentifier,
            "name": self.displayName,
            "headCoach": self.headCoach
        ]
        return dict
    }
    
}

//func delete() throws {
//    try FirebaseManager.shared.delete(self)
//}
//
//private static var databaseObjects: DatabaseReference {
//    FirebaseManager.shared.databaseManager.root.child("squads")
//}
//
//static func getObject(by uid: String, completionHandler handler: @escaping (SportSquad?) -> Void) {
//    Self.databaseObjects
//        .child(uid)
//        .getData { error, snapshot in
//            if let error = error {
//                print(error)
//                return
//            }
//            let object = Self(snapshot: snapshot)
//            handler(object)
//        }
//}

//init?(snapshot: DataSnapshot) {
//    if snapshot.value is NSNull {
//        print("Query result is nill")
//        return nil
//    }
//    let value = snapshot.value
//    switch value {
//    case let value as NSArray:
//        self.init(key: snapshot.key, array: value)
//    case let value as [String: Any]:
//        self.init(key: snapshot.key, dict: value)
//    default:
//        fatalError()
//    }
//}
//
//init?(key: String, array: NSArray) {
//    assert(array.count > 0)
//    guard let dict = array[0] as? [String: Any] else {
//        return nil
//    }
//    self.init(key: key, dict: dict)
//}
//
//init?(key: String, dict: [String: Any]) {
//    guard !dict.isEmpty,
//          let displayName = dict["name"] as? String,
//          let headCoach = dict["headCoach"] as? String else {
//        return nil
//    }
//
//    self.objectIdentifier = key
//    self.headCoach = headCoach
//    self.displayName = displayName
//}
