//
//  ClubImpl.swift
//  IceHockey
//
//  Created by  Buxlan on 11/23/21.
//

import Foundation

struct SquadImpl: Squad {
        
    // MARK: - Properties
    
    var objectIdentifier: String
    var displayName: String
    var headCoach: String
    
    // MARK: - Lifecircle
        
    init(databaseData: SquadDatabaseFlowData,
         storageData: StorageFlowData) {
        self.objectIdentifier = databaseData.objectIdentifier
        self.displayName = databaseData.displayName
        self.headCoach = databaseData.headCoach        
    }
    
    // MARK: - Helper methods
    
    func encode() -> [String: Any] {
        let dict: [String: Any] = [
            "uid": objectIdentifier,
            "name": displayName,
            "headCoach": headCoach
        ]
        return dict
    }
    
}
