//
//  HockeyTeam.swift
//  IceHockey
//
//  Created by  Buxlan on 9/4/21.
//

import Firebase

protocol SportTeam: FirebaseObject {
    var objectIdentifier: String { get set }
    var address: String { get set }
    var copyright: String { get set }
    var displayName: String { get set }
    var email: String { get set }
    var largeLogoID: String { get set }
    var smallLogoID: String { get set }
    var location: Coord? { get set }
    var phone: String { get set }
    var webSite: String { get set }
    var squadsIdentifiers: [String] { get set }
    
    func encode() -> [String: Any]
}

extension SportTeam {
    var isNew: Bool {
        return self.objectIdentifier.isEmpty
    }
}

class SportTeamProxy: SportTeam {
    var team: SportTeamImpl? {
        didSet {
            loadingCompletionHandler()
        }
    }
    var loadingCompletionHandler: () -> Void = {}
    
    var objectIdentifier: String {
        get { team?.objectIdentifier ?? "" }
        set { team?.objectIdentifier = newValue }
    }
    var address: String {
        get { team?.address ?? "" }
        set { team?.address = newValue }
    }
    var copyright: String {
        get { team?.copyright ?? "" }
        set { team?.copyright = newValue }
    }
    var displayName: String {
        get { team?.displayName ?? "" }
        set { team?.displayName = newValue }
    }
    var email: String {
        get { team?.email ?? "" }
        set { team?.email = newValue }
    }
    var largeLogoID: String {
        get { team?.largeLogoID ?? "" }
        set { team?.largeLogoID = newValue }
    }
    var smallLogoID: String {
        get { team?.smallLogoID ?? "" }
        set { team?.smallLogoID = newValue }
    }
    var location: Coord? {
        get { team?.location }
        set { team?.location = newValue }
    }
    var phone: String {
        get { team?.phone ?? "" }
        set { team?.phone = newValue }
    }
    var webSite: String {
        get { team?.webSite ?? "" }
        set { team?.webSite = newValue }
    }
    var squadsIdentifiers: [String] {
        get { team?.squadsIdentifiers ?? [] }
        set { team?.squadsIdentifiers = newValue }
    }
    
    func encode() -> [String: Any] {
        guard let team = team else {
            return [:]
        }
        return team.encode()

    }
    
}

struct SportTeamImpl: SportTeam {
    
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
    
    static var current = SportTeamManager.shared.current
    
    // MARK: - Lifecircle
    
    init(displayName: String,
         objectIdentifier: String,
         phone: String,
         smallLogoID: String,
         largeLogoID: String,
         copyright: String,
         squadsIdentifiers: [String],
         location: Coord? = nil,
         address: String = "-",
         email: String = "-",
         webSite: String = "") {
        self.objectIdentifier = objectIdentifier
        self.displayName = displayName
        self.phone = phone
        self.smallLogoID = smallLogoID
        self.largeLogoID = largeLogoID
        self.copyright = copyright
        self.squadsIdentifiers = squadsIdentifiers
        self.location = location
        self.address = address
        self.email = email
        self.webSite = webSite
    }
    
    init(databaseData: TeamDatabaseFlowData = DefaultTeamDatabaseFlowData(),
         storageData: TeamStorageFlowData = DefaultTeamStorageFlowData()) {
        
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
