//
//  HockeyTeamDetailViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 9/6/21.
//

import UIKit

struct HockeySquadPlayersSection {
    var role: HockeyPlayerRole
    var items: [SportPlayer]
}

struct HockeySquadDetailViewModel {
    var squad: SportSquad?
    var sections: [HockeySquadPlayersSection] {
        var items = [HockeySquadPlayersSection]()
        guard let squad = squad else {
            return items
        }
//        items.append(HockeySquadPlayersSection(role: .goalkeeper, items: squad.goalkeepers))
//        items.append(HockeySquadPlayersSection(role: .striker, items: squad.strikers))
//        items.append(HockeySquadPlayersSection(role: .defender, items: squad.defenders))
        return items
    }
    
    init(squad: SportSquad? = nil) {
        self.squad = squad
    }
    
    func item(at index: IndexPath) -> SportPlayer {
        return sections[index.section].items[index.row]
    }
}
