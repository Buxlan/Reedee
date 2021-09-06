//
//  HockeySquadViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 9/5/21.
//

import Foundation

struct HockeySquadViewModel {
    let items: [HockeySquad] = [
        HockeySquad(name: "Команда 2009 г.р.", headCoach: "Coach 0"),
        HockeySquad(name: "Команда 2010 г.р.", headCoach: "Coach 1"),
        HockeySquad(name: "Команда 2011 г.р.", headCoach: "Coach 2"),
        HockeySquad(name: "Команда 2012 г.р.", headCoach: "Coach 3"),
        HockeySquad(name: "Команда 2013 г.р.", headCoach: "Coach 4"),
        HockeySquad(name: "Команда 2014 г.р.", headCoach: "Coach 5"),
        HockeySquad(name: "Команда 2015 г.р.", headCoach: "Coach 6")
    ]
    
    func item(at index: IndexPath) -> HockeySquad {
        return items[index.row]
    }
}
