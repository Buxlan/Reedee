//
//  ClubProxy.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 11/23/21.
//

class ClubProxy: Club {
    
    var team: ClubImpl?
    
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
