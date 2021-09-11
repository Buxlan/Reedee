//
//  HockeySquadViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 9/5/21.
//

import Foundation

struct HockeySquadViewModel {
    let items: [SportSquad] = {
        var items = [SportSquad]()
        var coaches: [SportCoach]
        var squad: SportSquad
        coaches = [
            SportCoach(id: "", displayName: "Лукашонок А.П.", description: ""),
            SportCoach(id: "", displayName: "Костенко К.К.", description: ""),
            SportCoach(id: "", displayName: "Катосонов В.И.", description: "")
        ]
        squad = SportSquad(name: "Группа начальной подготовки (утро)", coaches: coaches)
        items.append(squad)
        
        coaches = [
            SportCoach(id: "", displayName: "Лукашонок А.П.", description: ""),
            SportCoach(id: "", displayName: "Степанов Г.Д.", description: "")
        ]
        squad = SportSquad(name: "Группа начальной подготовки (вечер)", coaches: coaches)
        items.append(squad)
        
        coaches = [
            SportCoach(id: "", displayName: "Мирошников А.Г.", description: "")
        ]
        squad = SportSquad(name: "Команда 2009 г.р.", coaches: coaches)
        items.append(squad)
        
        coaches = [
            SportCoach(id: "", displayName: "Степанов Г.Д.", description: "")
        ]
        squad = SportSquad(name: "Команда 2010 г.р.", coaches: coaches)
        items.append(squad)
        
        coaches = [
            SportCoach(id: "", displayName: "Головачев А.А.", description: "")
        ]
        squad = SportSquad(name: "Команда 2011 г.р.", coaches: coaches)
        items.append(squad)
        
        coaches = [
            SportCoach(id: "", displayName: "Головачев А.А.", description: "")
        ]
        squad = SportSquad(name: "Команда 2015 г.р.", coaches: coaches)
        items.append(squad)
        
        return items
    }()
    
    func item(at index: IndexPath) -> SportSquad {
        return items[index.row]
    }
}
