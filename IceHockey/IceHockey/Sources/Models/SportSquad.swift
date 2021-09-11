//
//  HockeySquad.swift
//  IceHockey
//
//  Created by  Buxlan on 9/5/21.
//

import Foundation

struct SportSquad {
    var name: String
    var headCoach: SportCoach?
    var coaches: [SportCoach]
    
    var strikers: [SportPlayer] = [
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 1),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 2),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 3),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 4),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 5),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 6),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .striker, gameNumber: 7)
    ]
    var defenders: [SportPlayer] = [
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 11),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 12),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 13),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 14),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 15),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 16),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 17),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 18),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .defender, gameNumber: 19)
    ]
    
    var goalkeepers: [SportPlayer] = [
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .goalkeeper, gameNumber: 1),
        SportPlayer(id: "0", displayName: "Бушмакин Егор", position: .goalkeeper, gameNumber: 2)
    ]    
}
