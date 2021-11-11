//
//  TrainingSchedule.swift
//  IceHockey
//
//  Created by  Buxlan on 11/10/21.
//

import Firebase
import UIKit
    
enum DayOfWeek: String, CustomStringConvertible, Codable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case unknown
    
    var description: String {
        switch self {
        case .sunday:
            return L10n.Day.sunday
        case .monday:
            return L10n.Day.monday
        case .tuesday:
            return L10n.Day.tuesday
        case .wednesday:
            return L10n.Day.wednesday
        case .thursday:
            return L10n.Day.thursday
        case .friday:
            return L10n.Day.friday
        case .saturday:
            return L10n.Day.saturday
        case .unknown:
            return L10n.Day.unknown
        }
    }
    
    init(rawValue: String) {
        switch rawValue {
        case "sunday":
            self = .sunday
        case "monday":
            self = .monday
        case "tuesday":
            self = .tuesday
        case "wednesday":
            self = .wednesday
        case "thursday":
            self = .thursday
        case "friday":
            self = .friday
        case "saturday":
            self = .saturday
        default:
            self = .unknown
        }
    }
}

enum TrainingType: String, Codable, CustomStringConvertible {
    case ice
    case gym
    case unknown
    
    var description: String {
        switch self {
        case .ice:
            return L10n.TrainingType.ice
        case .gym:
            return L10n.TrainingType.gym
        case .unknown:
            return L10n.TrainingType.unknown
        }
    }
    
    init(rawValue: String) {
        switch rawValue {
        case "ice":
            self = .ice
        case "gym":
            self = .gym
        default:
            self = .unknown
        }
    }
}

struct TrainingTime: Codable {
    var type: TrainingType
    var time: String
}

struct DailyTraining: Codable {
    var day: DayOfWeek
    var time: [TrainingTime]
    
    init?(day: String, data: Any) {
        guard let array = data as? NSArray else {
            return nil
        }
        var trainingTimes: [TrainingTime] = []
        for element in array {
            guard let dict = element as? [String: String] else {
                return nil
            }
            for (type, time) in dict {
                let trainingTime = TrainingTime(type: TrainingType(rawValue: type), time: time)
                trainingTimes.append(trainingTime)
            }
        }
        
        self.day = DayOfWeek(rawValue: day)
        self.time = trainingTimes
    }
}

struct TrainingSchedule: Codable {
    
    var uid: String
    var trainings: [DailyTraining]
    
    init(uid: String = "",
         trainings: [DailyTraining] = []) {
        self.uid = uid
        self.trainings = trainings
    }
    
    init?(key: String, dict: [String: Any]) {
        var trainings: [DailyTraining] = []
        dict.forEach { (key, value) in
            if let dailyTraining = DailyTraining(day: key, data: value) {
                trainings.append(dailyTraining)
            }
        }
        self.uid = key
        self.trainings = trainings
    }
    
    init?(key: String, array: NSArray) {
        var trainings: [DailyTraining] = []
        for element in array {
            guard let dict = element as? [String: NSArray] else {
                return nil
            }
            for (day, array) in dict {
                if let dailyTraining = DailyTraining(day: day, data: array) {
                    trainings.append(dailyTraining)
                }
            }
        }
        self.uid = key
        self.trainings = trainings
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

extension TrainingSchedule: FirebaseObject {
    
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
        return self.uid.isEmpty
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
    
    func prepareDataForSaving() -> [String: Any] {
        let dict: [String: Any] = [
            "uid": self.uid,
            "trainings": self.trainings
        ]
        return dict
    }
    
}
