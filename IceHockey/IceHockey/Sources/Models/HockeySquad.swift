//
//  HockeySquad.swift
//  IceHockey
//
//  Created by  Buxlan on 9/5/21.
//

import Foundation

struct HockeySquad {
    var name: String
    var headCoach: String
    
    var strikers: [HockeyPlayer] = [
        HockeyPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 1),
        HockeyPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 2),
        HockeyPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 3),
        HockeyPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 4),
        HockeyPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 5),
        HockeyPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 6),
        HockeyPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 7)
    ]
    var defenders: [HockeyPlayer] = [
        HockeyPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 11),
        HockeyPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 12),
        HockeyPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 13),
        HockeyPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 14),
        HockeyPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 15),
        HockeyPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 16),
        HockeyPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 17),
        HockeyPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 18),
        HockeyPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 19)
    ]
    
    var goalkeepers: [HockeyPlayer] = [
        HockeyPlayer(id: "0", displayName: "Бушмакин Егор", position: .goalkeeper, gameNumber: 1),
        HockeyPlayer(id: "0", displayName: "Бушмакин Егор", position: .goalkeeper, gameNumber: 2)
    ]    
}
