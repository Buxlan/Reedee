//
//  HockeyTeam.swift
//  IceHockey
//
//  Created by  Buxlan on 9/4/21.
//

import Firebase

struct SportTeam: FirebaseObject {
    
    // MARK: - Properties
    
    var objectIdentifier: String
    var displayName: String
    var phone: String
    var smallImageID: String
    var largeImageID: String
    var copyright: String
    var squadsIdentifiers: [String]
    var location: Coord?
    var address: String = "-"
    var email: String = ""
    var ourSquadsTitle: String = ""
    var webSite: String = ""
    
    var images: [ImageData] = []
    
    static var current = SportTeam(displayName: L10n.Team.listTitle,
                                   objectIdentifier: "redBears",
                                   phone: "79095626666",
                                   smallImageID: "",
                                   largeImageID: "",
                                   copyright: "Copyright © 2018 kidshockey.spb.ru",
                                   squadsIdentifiers: ["-Mmyxk7Vkh1q7_vQTfUv1", "-Mmyxk7Vkh1q7_vQTfUv2"],
                                   location: nil)
    
    var isNew: Bool {
        return self.objectIdentifier.isEmpty
    }
    
    // MARK: - Lifecircle
    
    init(displayName: String,
         objectIdentifier: String,
         phone: String,
         smallImageID: String,
         largeImageID: String,
         copyright: String,
         squadsIdentifiers: [String],
         location: Coord? = nil,
         address: String = "-",
         email: String = "-",
         webSite: String = "") {
        self.objectIdentifier = objectIdentifier
        self.displayName = displayName
        self.phone = phone
        self.smallImageID = smallImageID
        self.largeImageID = largeImageID
        self.copyright = copyright
        self.squadsIdentifiers = squadsIdentifiers
        self.location = location
        self.address = address
        self.email = email
        self.webSite = webSite
    }
    
    init(databaseData: TeamDatabaseFlowData,
         storageData: TeamStorageFlowData) {
        
        self.objectIdentifier = databaseData.objectIdentifier
        self.displayName = databaseData.displayName
        self.phone = databaseData.phone
        self.smallImageID = databaseData.smallLogoID
        self.largeImageID = databaseData.largeLogoID
        self.copyright = databaseData.copyright
        self.squadsIdentifiers = databaseData.squadsIDs
        self.location = databaseData.location
        self.address = databaseData.address
        self.email = databaseData.email
        self.webSite = databaseData.webSite
        self.images = storageData.images
        
    }
    
    // MARK: - Helper methods
    
    func encode() -> [String: Any] {
        var dict: [String: Any] = [
            "uid": self.objectIdentifier,
            "copyright": self.copyright,
            "displayName": self.displayName,
            "largeLogo": self.largeImageID,
            "smallLogo": self.smallImageID,
            "phone": self.phone,
            "squads": self.squadsIdentifiers,
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
    
}
