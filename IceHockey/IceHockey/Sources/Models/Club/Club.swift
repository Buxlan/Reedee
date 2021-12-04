//
//  Club.swift
//  IceHockey
//
//  Created by  Buxlan on 9/4/21.
//

import Firebase

protocol Club: FirebaseObject {
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
    
    var squads: [Squad] { get set }
    
    func encode() -> [String: Any]
}
