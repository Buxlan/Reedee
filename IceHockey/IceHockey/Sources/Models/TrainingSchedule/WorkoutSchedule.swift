//
//  TrainingSchedule.swift
//  IceHockey
//
//  Created by  Buxlan on 11/10/21.
//

import Firebase
import UIKit

struct WorkoutSchedule: Codable {
    
    var objectIdentifier: String = ""
    var workouts: [DayWorkout] = []    
    
    init?(key: String, dict: [String: Any]) {
        var trainings: [DayWorkout] = []
        dict.forEach { (key, value) in
            if let dailyTraining = DayWorkout(day: key, data: value) {
                trainings.append(dailyTraining)
            }
        }
        self.objectIdentifier = key
        self.workouts = trainings
    }
    
    init?(key: String, array: NSArray) {
        var trainings: [DayWorkout] = []
        for element in array {
            guard let dict = element as? [String: NSArray] else {
                return nil
            }
            for (day, array) in dict {
                if let dailyTraining = DayWorkout(day: day, data: array) {
                    trainings.append(dailyTraining)
                }
            }
        }
        self.objectIdentifier = key
        self.workouts = trainings
    }
    
    init?(snapshot: DataSnapshot) {
        if snapshot.value is NSNull {
            return nil
        }
        let uid = snapshot.key
        let value = snapshot.value
        switch value {
        case let value as NSArray:
            self.init(key: uid, array: value)
        case let value as [String: Any]:
            self.init(key: uid, dict: value)
        default:
            return nil
        }
    }
    
}

extension WorkoutSchedule: FirebaseObject {
    
    private static var databaseObjects: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("trainingSchedule")
    }
    
    static func getObject(by uid: String,
                          completionHandler handler: @escaping (Self?) -> Void) {
        Self.databaseObjects
            .child(uid)
            .getData { error, snapshot in
                if let error = error {
                    print(error)
                    return
                }
                if snapshot.value is NSNull {
                    print("Query result is nil")
                    handler(nil)
                    return
                }
                let object = Self(snapshot: snapshot)
                handler(object)
            }
    }
    
    func delete() throws {
        try FirebaseManager.shared.delete(self)
    }
        
    var isNew: Bool {
        return objectIdentifier.isEmpty
    }
    
    func checkProperties() -> Bool {
        return true
    }
    
    func save() throws {
        
        if !checkProperties() {
            print("Error. Properties are wrong")
        }
        
        if isNew {
            try ExistingTrainingScheduleFirebaseSaver(object: self).save()
        } else {
            try NewTrainingScheduleFirebaseSaver(object: self).save()
        }
    }
    
    func encode() -> [String: Any] {
        let dict: [String: Any] = [
            "uid": self.objectIdentifier,
            "trainings": self.workouts
        ]
        return dict
    }
    
}
