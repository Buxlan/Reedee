//
//  TrainingScheduleCreator.swift
//  IceHockey
//
//  Created by  Buxlan on 11/21/21.
//

import Firebase

protocol TrainingScheduleCreator {
    
    func create(snapshot: DataSnapshot,
                with completionHandler: @escaping (TrainingSchedule?) -> Void)
    -> TrainingSchedule?
    
}

struct TrainingScheduleCreatorImpl: TrainingScheduleCreator {
    
    func create(snapshot: DataSnapshot,
                with completionHandler: @escaping (TrainingSchedule?) -> Void)
    -> TrainingSchedule? {
        
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else {
            return nil
        }
        let builder = TrainingScheduleBuilder(key: uid)
        builder.build(completionHandler: completionHandler)
        let object = builder.getResult()
        return object
    }
    
}
