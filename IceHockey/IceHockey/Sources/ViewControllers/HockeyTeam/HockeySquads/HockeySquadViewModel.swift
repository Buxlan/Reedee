//
//  HockeySquadViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 9/5/21.
//

import Foundation

struct HockeySquadViewModel {
    let items: [SportSquad] = []
    
    func item(at index: IndexPath) -> SportSquad {
        return items[index.row]
    }
}
