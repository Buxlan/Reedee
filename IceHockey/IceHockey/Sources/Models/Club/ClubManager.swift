//
//  ClubManager.swift
//  IceHockey
//
//  Created by  Buxlan on 11/23/21.
//

import Foundation

struct WeakClubObserver {
    weak var value: ClubObserver?
}

protocol ClubObserver: AnyObject {
    func didChangeTeam(_ club: Club)
}

class ClubManager {
    
    static let shared = ClubManager()
    var current: Club
    private var observers: [WeakClubObserver] = []    
            
    private init() {
        current = ClubProxy()
        guard let teamID = Bundle.main.object(forInfoDictionaryKey: "teamID") as? String else {
            return
        }
        current = FirebaseObjectFactory.shared.makeTeam(with: teamID) {
            self.observers.forEach { [weak self] weakObserver in
                guard let self = self else { return }
                weakObserver.value?.didChangeTeam(self.current)
            }
        }
    }
    
    func addObserver(_ observer: ClubObserver) {
        let weakObserver = WeakClubObserver(value: observer)
        observers.append(weakObserver)
    }
    
    func removeObserver(_ observer: ClubObserver) {
        if let index = observers.firstIndex(where: { $0.value === observer }) {
            observers.remove(at: index)
        }
    }
    
}
