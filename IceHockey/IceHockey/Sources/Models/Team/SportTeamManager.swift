//
//  SportTeamManager.swift
//  IceHockey
//
//  Created by  Buxlan on 11/23/21.
//

import Foundation

class SportTeamManager {
    
    static let shared = SportTeamManager()
    
    var current: SportTeam
    
    private init() {
        current = SportTeam()
        guard let teamID = Bundle.main.object(forInfoDictionaryKey: "teamID") as? String else {
            return
        }
        FirebaseObjectFactory().makeTeam(with: teamID) { team in
            if let team = team {
                self.current = team
            }
        }
    }
    
}
