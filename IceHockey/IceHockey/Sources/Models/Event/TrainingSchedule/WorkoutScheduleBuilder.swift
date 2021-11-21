//
//  TrainingScheduleBuilder.swift
//  IceHockey
//
//  Created by  Buxlan on 11/21/21.
//

import Firebase
import Foundation

class WorkoutScheduleBuilder {
    
    // MARK: - Properties
    
    private let snapshot: DataSnapshot
    private var data: NSArray?
    
    // MARK: - Lifecircle
    
    init(snapshot: DataSnapshot) {
        self.snapshot = snapshot
    }
    
    // MARK: - Helper Methods
    
    func build() {
        guard let array = snapshot.value as? NSArray else {
            return
        }
        self.data = array
    }
    
    func getInstance() -> WorkoutSchedule? {
        guard let data = data else {
            return nil
        }
        let object = WorkoutSchedule(key: snapshot.key, array: data)
        return object
    }
    
}
