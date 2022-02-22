//
//  NewMatchResultFirebaseSaver.swift
//  IceHockey
//
//  Created by  Buxlan on 11/8/21.
//

import Firebase

struct MatchResultFirebaseSaver {
    
    // MARK: - Properties
    
    typealias DataType = MatchResult
    internal let object: DataType
    
    internal var eventsDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("events")
    }
    
    internal var imagesDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("images")
    }
    
    internal var imagesStorageReference: StorageReference {
        let ref = FirebaseManager.shared.storageManager.root.child("events")
        return ref
    }
    
    internal var eventReference: DatabaseReference {
        var ref: DatabaseReference
        if object.isNew {
            ref = eventsDatabaseReference.childByAutoId()
        } else {
            ref = eventsDatabaseReference.child(object.objectIdentifier)
        }
        return ref
    }
    
    private var orderValue: Int {
        // for order purposes
        var dateComponent = DateComponents()
        dateComponent.calendar = Calendar.current
        dateComponent.year = 2024
        guard let templateDate = dateComponent.date else {
            fatalError()
        }
        let order = Int(templateDate.timeIntervalSince(object.date))
        return order
    }
    
    // MARK: - Lifecircle
    
    init(object: DataType) {
        self.object = object
    }
    
    // MARK: - Helper functions
    
    func save(completionHandler: (SaveObjectError?) -> Void) {
        if object.isNew {
            saveExisting()
        } else {
            saveNew()
        }
        completionHandler(nil)
    }
    
    func saveNew() {
        var dataDict = encodeObject()
        dataDict["order"] = orderValue
        eventReference.setValue(dataDict) { error, _ in
            if let error = error {
                print("Saving error: \(error)")
                return
            }
        }
    }
    
    func encodeObject() -> [String: Any] {
        let interval = object.date.timeIntervalSince1970
        let dict: [String: Any] = [
            "uid": object.objectIdentifier,
            "author": object.authorID,
            "title": object.title,
            "homeTeam": object.homeTeam,
            "awayTeam": object.awayTeam,
            "homeTeamScore": object.homeTeamScore,
            "awayTeamScore": object.awayTeamScore,
            "stadium": object.stadium,
            "type": object.type.rawValue,
            "date": Int(interval),
            "order": orderValue
        ]
        return dict
    }
    
    func saveExisting() {
        var dataDict = encodeObject()
        dataDict["order"] = orderValue
        
        eventReference.setValue(dataDict) { error, _ in
            if let error = error {
                print("Saving error: \(error)")
                return
            }
        }
    }
    
}
