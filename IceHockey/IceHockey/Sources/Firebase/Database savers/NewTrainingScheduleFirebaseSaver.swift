//
//  NewTrainingScheduleFirebaseSaver.swift
//  IceHockey
//
//  Created by  Buxlan on 11/10/21.
//

import Firebase

struct NewTrainingScheduleFirebaseSaver: TrainingScheduleFirebaseSaver {
    
    // MARK: - Properties
    
    typealias DataType = TrainingSchedule
    internal let object: DataType
    
    internal var eventsDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("trainingSchedule")
    }
        
    internal var objectReference: DatabaseReference {
        var ref: DatabaseReference
        if object.isNew {
            ref = eventsDatabaseReference.childByAutoId()
        } else {
            ref = eventsDatabaseReference.child(object.uid)
        }
        return ref
    }
    
    // MARK: - Lifecircle
    
    init(object: DataType) {
        self.object = object
    }
    
    // MARK: - Helper functions
    
    func save() throws {
        let dataDict = object.prepareDataForSaving()        
        objectReference.setValue(dataDict) { (error, ref) in
            if let error = error {
                print(error)
                return
            }
            guard let _ = ref.key else {
                return
            }
        }
    }
}
