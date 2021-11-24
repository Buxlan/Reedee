//
//  EventDetailViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 10/18/21.
//

import Firebase

class EventDetailViewModel: NSObject {
    
    // MARK: - Properties
    struct SectionData {
        let squad: Squad
        let schedule: WorkoutSchedule
    }
    
    var sections: [SectionData] = []
    private var loadings: [String] = []
    
    var shouldRefreshRelay = {}
    
    var objectsDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("squads")
    }
    
    // MARK: Lifecircle
        
    // MARK: - Hepler functions    
    
}
