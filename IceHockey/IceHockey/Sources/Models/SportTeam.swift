//
//  HockeyTeam.swift
//  IceHockey
//
//  Created by  Buxlan on 9/4/21.
//

import Foundation
import Firebase

struct SportTeam: Codable, FirebaseObject {
    
    // MARK: - Properties
    
    var uid: String
    var displayName: String
    var phone: String
    var smallImageID: String
    var largeImageID: String
    var copyright: String
    var squadIDs: [String]
    
    static var current = SportTeam(displayName: L10n.Team.title,
                                   uid: "redBears",
                                   phone: "79095626666",
                                   smallImageID: "",
                                   largeImageID: "",
                                   copyright: "Copyright © 2018 kidshockey.spb.ru",
                                   squadIDs: [])
    
    // MARK: - Lifecircle
    
    init(displayName: String,
         uid: String,
         phone: String,
         smallImageID: String,
         largeImageID: String,
         copyright: String,
         squadIDs: [String]) {
        self.uid = uid
        self.displayName = displayName
        self.phone = phone
        self.smallImageID = smallImageID
        self.largeImageID = largeImageID
        self.copyright = copyright
        self.squadIDs = squadIDs
    }
    
    init?(snapshot: DataSnapshot) {
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else { return nil }
        self.init(key: uid, dict: dict as NSDictionary)
    }
    
    init?(key: String, dict: NSDictionary) {
        guard let displayName = dict["displayName"] as? String else { return nil }
        guard let phone = dict["phone"] as? String else { return nil }
        guard let smallImageID = dict["smallLogo"] as? String else { return nil }
        guard let largeImageID = dict["largeLogo"] as? String else { return nil }
        guard let copyright = dict["copyright"] as? String else { return nil }
        guard let squadIDs = dict["squads"] as? [String] else { return nil }
                
        self.uid = key
        self.displayName = displayName
        self.phone = phone
        self.smallImageID = smallImageID
        self.largeImageID = largeImageID
        self.copyright = copyright
        self.squadIDs = squadIDs
    }
    
    var isNew: Bool {
        return self.uid.isEmpty
    }
    
    // MARK: - Helper methods
        
    func checkProperties() -> Bool {
        return true
    }
    
    func prepareDataForSaving() -> [String: Any] {        
        let dict: [String: Any] = [
            "uid": self.uid,
            "copyright": self.copyright,
            "displayName": self.displayName,
            "largeLogo": self.largeImageID,
            "smallLogo": self.smallImageID,
            "phone": self.phone,
            "squads": self.squadIDs
        ]
        return dict
    }
    
    func save() throws {
        
        if !checkProperties() {
            print("Error. Properties are wrong")
        }
        
        if isNew {
            try ExistingSportTeamFirebaseSaver(object: self).save {
                print("!!!existing ok!!!")
            }
        } else {
            try NewSportTeamFirebaseSaver(object: self).save {
                print("!!!new ok!!!")
            }
        }
    }
    
    func delete() {
        do {
            try FirebaseManager.shared.delete(self)
        } catch AppError.dataMismatch {
            print("Data mismatch")
        } catch {
            print("Some other error")
        }
    }
    
}
