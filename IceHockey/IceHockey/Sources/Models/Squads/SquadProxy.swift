//
//  ClubProxy.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 11/23/21.
//

class SquadProxy: Squad {
    
    var squad: SquadImpl?
    
    var objectIdentifier: String {
        get { squad?.objectIdentifier ?? "" }
        set { squad?.objectIdentifier = newValue }
    }
    var displayName: String {
        get { squad?.displayName ?? "" }
        set { squad?.displayName = newValue }
    }
    var headCoach: String {
        get { squad?.headCoach ?? "" }
        set { squad?.headCoach = newValue }
    }
    
    func encode() -> [String: Any] {
        guard let squad = squad else {
            return [:]
        }
        return squad.encode()

    }
    
}
