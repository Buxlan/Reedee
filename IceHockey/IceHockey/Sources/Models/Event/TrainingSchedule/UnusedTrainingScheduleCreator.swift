//
//  TrainingScheduleCreator.swift
//  IceHockey
//
//  Created by  Buxlan on 11/21/21.
//

import Firebase

struct UsusedTrainingScheduleCreator {
    
    func create(snapshot: DataSnapshot,
                with completionHandler: @escaping (WorkoutSchedule?) -> Void)
    -> WorkoutSchedule? {
        
        let builder = WorkoutScheduleBuilder(snapshot: snapshot)
        builder.build()
        let object = builder.getInstance()
        return object
    }
    
}
