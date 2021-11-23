//
//  SportTeamManager.swift
//  IceHockey
//
//  Created by  Buxlan on 11/23/21.
//

import Foundation

struct WeakTeamObserver {
    weak var value: TeamObserver?
}

protocol TeamObserver: AnyObject {
    func didChangeTeam(_ newTeam: SportTeam)
}

class SportTeamManager {
    
    static let shared = SportTeamManager()
    var current: SportTeam
    private var observers: [WeakTeamObserver] = []
            
    private init() {
        current = SportTeamProxy()
        guard let teamID = Bundle.main.object(forInfoDictionaryKey: "teamID") as? String else {
            return
        }
        current = FirebaseObjectFactory().makeTeam(with: teamID) {
            self.observers.forEach { weakObserver in
                weakObserver.value?.didChangeTeam(self.current)
            }
        }
    }
    
    func addObserver(_ observer: TeamObserver) {
        let weakObserver = WeakTeamObserver(value: observer)
        observers.append(weakObserver)
    }
    
    func removeObserver(_ observer: TeamObserver) {
        if let index = observers.firstIndex(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
    }
    
}
