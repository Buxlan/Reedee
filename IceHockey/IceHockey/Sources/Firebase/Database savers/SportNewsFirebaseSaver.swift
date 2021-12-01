//
//  NewSportNewsFirebaseSaver.swift
//  IceHockey
//
//  Created by  Buxlan on 10/27/21.
//

import Firebase

class SportNewsFirebaseSaver {
    
    // MARK: - Properties
    
    typealias DataType = SportNews
    internal var object: DataType
    private var imagesPath = "events"
    
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
            return 0
        }
        let order = Int(templateDate.timeIntervalSince(object.date))
        return order
    }
    
    // MARK: - Lifecircle
    
    init(object: DataType) {
        self.object = object
    }
    
    // MARK: - Helper functions
    
    func save(completionHandler: @escaping (SportEventSaveError?) -> Void) {
        if object.isNew {
            saveNew(completionHandler: completionHandler)
        } else {
            saveExisting(completionHandler: completionHandler)
        }
    }
    
    func saveNew(completionHandler: @escaping (SportEventSaveError?) -> Void) {
                
        let imagesManager = ImagesManager.shared
        object.order = orderValue
        
        // prepare images array
        let imagesCount = object.images.count
        var imagesTableData: [String: String] = [:]
        for (index, imageData) in object.images.reversed().enumerated() {
            if imageData.isRemoved || imageData.image == nil {
                let index = imagesCount - 1 - index
                object.images.remove(at: index)
                continue
            }
            if imageData.imageID.isEmpty {
                guard let imageID = self.imagesDatabaseReference.childByAutoId().key else {
                    completionHandler(.storageError)
                    return
                }
                imagesTableData[imageID] = imagesManager.getImageName(withID: imageID)
                object.images[index].imageID = imageID
            } else {
                let imageID = imageData.imageID
                imagesTableData[imageID] = imagesManager.getImageName(withID: imageID)
            }
        }
        
        saveData(imagesDictionary: imagesTableData, completionHandler: completionHandler)
        
    }
    
    func saveExisting(completionHandler: @escaping (SportEventSaveError?) -> Void) {
        
        let imagesManager = ImagesManager.shared
        object.order = orderValue
                
        // prepare images array
        let imagesCount = object.images.count
        var imagesTableData: [String: String] = [:]
        for (index, imageData) in object.images.reversed().enumerated() {
            if imageData.imageID.isEmpty,
               !imageData.isRemoved {
                guard let imageID = self.imagesDatabaseReference.childByAutoId().key else {
                    completionHandler(.storageError)
                    return
                }
                let index = imagesCount - 1 - index
                imagesTableData[imageID] = imagesManager.getImageName(withID: imageID)
                object.images[index].imageID = imageID
            } else {
                let imageName = imagesManager.getImageName(withID: imageData.imageID)
                if imageData.isRemoved {
                    let imageStorageRef = imagesStorageReference
                        .child(self.object.objectIdentifier)
                        .child(imageName)
                    imageStorageRef.delete()
                    let index = imagesCount - 1 - index
                    object.images.remove(at: index)
                } else {
                    let imageID = imageData.imageID
                    imagesTableData[imageID] = imageName
                }
            }
        }
        
        saveData(imagesDictionary: imagesTableData, completionHandler: completionHandler)
        
    }
        
    private func saveData(imagesDictionary imagesTableData: [String: String], completionHandler: @escaping (SportEventSaveError?) -> Void) {
        
        var storageErrorWasHappened = false
        var handlers: [String: (StorageMetadata?, Error?) -> Void] = [:]
        imagesTableData.forEach { (key, _) in
            handlers[key] = { (_, error) in
                if let index = handlers.firstIndex(where: { (dictKey, _) in
                    key == dictKey
                }) {
                    handlers.remove(at: index)
                }
                if error != nil {
                    storageErrorWasHappened = true
                }
                if handlers.isEmpty {
                    let error = storageErrorWasHappened ? SportEventSaveError.storageError : nil
                    completionHandler(error)
                }
            }
        }
        
        let dataDict = object.encode()
        eventReference.setValue(dataDict) { (error, ref) in
            guard error == nil,
               let objectIdentifier = ref.key else {
                completionHandler(.databaseError)
                return
            }
            
            if imagesTableData.isEmpty {
                completionHandler(nil)
                return
            }
            self.imagesDatabaseReference.updateChildValues(imagesTableData)
            self.object.images.forEach { [weak self] imageData in
                guard let self = self,
                      let data = imageData.image?.pngData(),
                      let imageName = imagesTableData[imageData.imageID],
                      let handler = handlers[imageData.imageID] else {
                          assertionFailure()
                          return
                }
                let ref = self.imagesStorageReference.child(objectIdentifier).child(imageName)
                ref.putData(data, metadata: nil, completion: handler)
            }
            
        }
        
    }
    
}
