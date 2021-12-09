//
//  ClubProxy.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 11/23/21.
//

typealias EmptyClub = ClubProxy

class ClubProxy: Club {
    
    var object: ClubImpl?
    
    var objectIdentifier: String {
        get { object?.objectIdentifier ?? "" }
        set { object?.objectIdentifier = newValue }
    }
    var address: String {
        get { object?.address ?? "" }
        set { object?.address = newValue }
    }
    var copyright: String {
        get { object?.copyright ?? "" }
        set { object?.copyright = newValue }
    }
    var displayName: String {
        get { object?.displayName ?? "" }
        set { object?.displayName = newValue }
    }
    var email: String {
        get { object?.email ?? "" }
        set { object?.email = newValue }
    }
    var largeLogoID: String {
        get { object?.largeLogoID ?? "" }
        set { object?.largeLogoID = newValue }
    }
    var smallLogoID: String {
        get { object?.smallLogoID ?? "" }
        set { object?.smallLogoID = newValue }
    }
    var location: Coord? {
        get { object?.location }
        set { object?.location = newValue }
    }
    var phone: String {
        get { object?.phone ?? "" }
        set { object?.phone = newValue }
    }
    var webSite: String {
        get { object?.webSite ?? "" }
        set { object?.webSite = newValue }
    }
    var squadsIdentifiers: [String] {
        get { object?.squadsIdentifiers ?? [] }
        set { object?.squadsIdentifiers = newValue }
    }
    
    var squads: [Squad] {
        get { object?.squads ?? [] }
        set { object?.squads = newValue }
    }
    
    func encode() -> [String: Any] {
        guard let team = object else {
            return [:]
        }
        return team.encode()

    }
    
}
