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

enum SaveObjectError: LocalizedError {
    case wrongPropertiesError
    case wrongInputError
    case databaseError(String)
    case storageError
    case objectEventError
    
    var errorDescription: String? {
        switch self {
        case .wrongPropertiesError:
            return "Not every properties is defined"
        case .wrongInputError:
            return "Wrong type of input data"
        case .databaseError(let text):
            return text
        case .storageError:
            return "Storage error occured"
        case .objectEventError:
            return "Object event error occured"
        }
    }
}

protocol SportEventFirebaseSaver: ObjectFirebaseSaver where DataType == SportEvent {
    
}

protocol SportUserFirebaseSaver: ObjectFirebaseSaver where DataType == SportUser {
    
}

protocol TrainingScheduleFirebaseSaver: ObjectFirebaseSaver where DataType == WorkoutSchedule {
    
}
