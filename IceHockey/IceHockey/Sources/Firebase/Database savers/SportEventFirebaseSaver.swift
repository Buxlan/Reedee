//
//  SportEventFirebaseSaver.swift
//  IceHockey
//
//  Created by  Buxlan on 10/27/21.
//

import Firebase

protocol ObjectFirebaseSaver {
    associatedtype DataType
    var object: DataType { get }
    func save() throws
}

enum SportEventSaveError: LocalizedError {
    case wrongProperties
    case wrongInput
    
    var errorDescription: String? {
        switch self {
        case .wrongProperties:
            return "Not every properties is defined"
        case .wrongInput:
            return "Wrong type of input data"
        }
    }
}

protocol SportEventFirebaseSaver: ObjectFirebaseSaver where DataType == SportEvent {
    
}

protocol SportUserFirebaseSaver: ObjectFirebaseSaver where DataType == SportUser {
    
}

protocol TrainingScheduleFirebaseSaver: ObjectFirebaseSaver where DataType == WorkoutSchedule {
    
}
