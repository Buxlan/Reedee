//
//  HockeyTeam.swift
//  IceHockey
//
//  Created by  Buxlan on 9/4/21.
//

import Foundation

struct SportTeam: Codable {    
    var displayName: String
    var uuid: String
    var phoneNumber: String
    var logoImageName: String
    var copyright: String
    
    static var current = SportTeam(displayName: L10n.Team.title,
                                   uuid: "1",
                                   phoneNumber: "79095626666",
                                   logoImageName: "logo",
                                   copyright: "Copyright © 2018 kidshockey.spb.ru")
}
