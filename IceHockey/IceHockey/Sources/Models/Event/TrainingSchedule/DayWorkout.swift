//
//  DayWorkout.swift
//  IceHockey
//
//  Created by  Buxlan on 11/22/21.
//

import Foundation

struct DayWorkout: Codable {
    var day: DayOfWeek
    var time: [Workout]
    
    init?(day: String, data: Any) {
        guard let array = data as? NSArray else {
            return nil
        }
        var trainingTimes: [Workout] = []
        for element in array {
            guard let dict = element as? [String: String] else {
                return nil
            }
            for (type, time) in dict {
                let trainingTime = Workout(type: TrainingType(rawValue: type), time: time)
                trainingTimes.append(trainingTime)
            }
        }
        
        self.day = DayOfWeek(rawValue: day)
        self.time = trainingTimes
    }
}
