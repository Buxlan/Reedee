//
//  ClubImpl.swift
//  IceHockey
//
//  Created by  Buxlan on 11/23/21.
//

import Foundation

struct ClubImpl: Club {
    
    // MARK: - Properties
    var objectIdentifier: String
    var displayName: String
    var phone: String
    var smallLogoID: String
    var largeLogoID: String
    var copyright: String
    var squadsIdentifiers: [String]
    var location: Coord?
    var address: String = "-"
    var email: String = ""
    var webSite: String = ""
    
    var images: [ImageData] = []
    
    static var current = ClubManager.shared.current
    
    // MARK: - Lifecircle   
    
    init(databaseData: ClubDatabaseFlowData = EmptyClubDatabaseFlowData(),
         storageData: ClubStorageFlowData = EmptyClubStorageFlowData()) {
        
        self.objectIdentifier = databaseData.objectIdentifier
        self.displayName = databaseData.displayName
        self.phone = databaseData.phone
        self.smallLogoID = databaseData.smallLogoID
        self.largeLogoID = databaseData.largeLogoID
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
            "largeLogo": self.largeLogoID,
            "smallLogo": self.smallLogoID,
            "phone": self.phone,
            "squads": self.squadsIdentifiers,
            "address": self.address,
            "email": self.email
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
