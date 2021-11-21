//
//  HockeyTeam.swift
//  IceHockey
//
//  Created by  Buxlan on 9/4/21.
//

import Foundation
import Firebase
import CoreLocation

struct Coord: Codable {
    var longitude: Double
    var latitude: Double
    
    init() {
        self.latitude = 0.0
        self.longitude = 0.0
    }
    
    init(longitude: Double, latitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

struct SportTeam: Codable, FirebaseObject {    
    
    // MARK: - Properties
    
    var uid: String
    var displayName: String
    var phone: String
    var smallImageID: String
    var largeImageID: String
    var copyright: String
    var squadIDs: [String]
    var location: Coord?
    var address: String = "-"
    var email: String = ""
    var ourSquadsTitle: String = ""
    var webSite: String = ""
    
    static var current = SportTeam(displayName: L10n.Team.listTitle,
                                   uid: "redBears",
                                   phone: "79095626666",
                                   smallImageID: "",
                                   largeImageID: "",
                                   copyright: "Copyright © 2018 kidshockey.spb.ru",
                                   squadIDs: ["-Mmyxk7Vkh1q7_vQTfUv1", "-Mmyxk7Vkh1q7_vQTfUv2"],
                                   location: nil)
    
    var isNew: Bool {
        return self.uid.isEmpty
    }
    
    private static var databaseObjects: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("teams")
    }
    
    // MARK: - Lifecircle
    
    init(displayName: String,
         uid: String,
         phone: String,
         smallImageID: String,
         largeImageID: String,
         copyright: String,
         squadIDs: [String],
         location: Coord? = nil,
         address: String = "-",
         email: String = "-",
         ourSquardTitle: String = "",
         webSite: String = "") {
        self.uid = uid
        self.displayName = displayName
        self.phone = phone
        self.smallImageID = smallImageID
        self.largeImageID = largeImageID
        self.copyright = copyright
        self.squadIDs = squadIDs
        self.location = location
        self.address = address
        self.email = email
        self.ourSquadsTitle = ourSquardTitle
        self.webSite = webSite
    }
    
    init?(snapshot: DataSnapshot) {
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else { return nil }
        self.init(key: uid, dict: dict)
    }
    
    // swiftlint:disable:next cyclomatic_complexity
    init?(key: String, dict: [String: Any]) {
        
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
        
        if let webSite = dict["webSite"] as? String {
            self.webSite = webSite
        }
        if let address = dict["address"] as? String {
            self.address = address
        }
        if let email = dict["email"] as? String {
            self.email = email
        }
        if let ourSquadsTitle = dict["ourSquadsTitle"] as? String {
            self.ourSquadsTitle = ourSquadsTitle
        }
        if let coordDict = dict["location"] as? [String: NSNumber],
           let latitude = coordDict["latitude"] as? Double,
           let longitude = coordDict["longitude"] as? Double {
            self.location = Coord(longitude: longitude, latitude: latitude)
        }
        
    }
    
    // MARK: - Helper methods
        
    func checkProperties() -> Bool {
        return true
    }
    
    func prepareDataForSaving() -> [String: Any] {
        var dict: [String: Any] = [
            "uid": self.uid,
            "copyright": self.copyright,
            "displayName": self.displayName,
            "largeLogo": self.largeImageID,
            "smallLogo": self.smallImageID,
            "phone": self.phone,
            "squads": self.squadIDs,
            "address": self.address,
            "email": self.email,
            "ourSquardTitle": self.ourSquadsTitle
        ]
        
        if let location = location {
            let locDict: [String: NSNumber] = [
                "latitude": location.latitude as NSNumber,
                "longitude": location.longitude as NSNumber
            ]
            dict["location"] = locDict
        }
        
        return dict
    }
    
    func save() throws {
        
        if !checkProperties() {
            print("Error. Properties are wrong")
        }
        
        if isNew {
            try ExistingSportTeamFirebaseSaver(object: self).save()
        } else {
            try NewSportTeamFirebaseSaver(object: self).save()
        }
    }
    
    func delete() throws {
        try FirebaseManager.shared.delete(self)        
    }
    
    static func getObject(by uid: String, completionHandler handler: @escaping (Self?) -> Void) {
        Self.databaseObjects
            .child(uid)
            .getData { error, snapshot in
                if let error = error {
                    print(error)
                    return
                }
                if snapshot.value is NSNull {
                    fatalError("Current team is nil")
                }
                let team = SportTeam(snapshot: snapshot)
                handler(team)
            }
    }
    
}
