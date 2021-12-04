//
//  ContactsViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 10/20/21.
//

import Firebase

struct ContactsModel {
    
}

struct ContactsViewModel {
    
    // MARK: - Properties
    
    var club: Club
    
    struct SectionData {
        let squad: Squad
        let schedule: WorkoutSchedule
    }
    var sections: [SectionData] = []
    
    var shouldRefreshRelay = {}
    
    // MARK: Lifecircle
    
    // MARK: - Hepler functions
    
    func update() {
        
    }
    
}
