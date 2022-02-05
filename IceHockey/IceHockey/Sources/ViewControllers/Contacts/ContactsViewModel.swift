//
//  ContactsViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 10/20/21.
//

import Firebase

struct ContactsModel {
    
}

class ContactsViewModel {
    
    // MARK: - Properties
    
    var club: Club?
    
    struct SectionData {
        let squad: Squad
        let schedule: WorkoutSchedule
    }
    var sections: [SectionData] = []
    
    var onRefresh = {}
    
    // MARK: Lifecircle
    
    init(club: Club?) {
        self.club = club
        if club != nil {
            update()
        }
        ClubManager.shared.addObserver(self)
    }
    
    deinit {
        ClubManager.shared.removeObserver(self)
    }
    
    // MARK: - Hepler functions
    
    func update() {
        onRefresh()
    }
    
}

extension ContactsViewModel: ClubObserver {
    
    func didChangeTeam(_ club: Club) {
        self.club = club
        update()
    }
    
}
