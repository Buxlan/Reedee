//
//  ExistingSportEventFirebaseSaver.swift
//  IceHockey
//
//  Created by  Buxlan on 10/27/21.
//

import Firebase

struct ExistingSportEventFirebaseSaver: SportEventFirebaseSaver {
    
    // MARK: - Properties
    
    internal let event: SportEvent
    
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
        if event.isNew {
            ref = eventsDatabaseReference.childByAutoId()
        } else {
            ref = eventsDatabaseReference.child(event.uid)
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
        let order = Int(templateDate.timeIntervalSince(event.date))
        return order
    }
    
    // MARK: - Lifecircle
    
    init(event: SportEvent) {
        self.event = event
    }
    
    // MARK: - Helper functions
    
    func save(completionHandler: @escaping () -> Void) throws {
        
        var dataDict = event.prepareDataForSaving()
        dataDict["order"] = orderValue
        
        eventReference.child("images").getData { (error, snapshot) in
            if let error = error {
                print(error)
                completionHandler()
                return
            }
            let oldImageIDs = snapshot.value as? [String] ?? []
            
            for imageId in oldImageIDs {
                if event.imageIDs.firstIndex(of: imageId) != nil {
                    continue
                }
                // need to remove image from storage
                let imageName = SportEvent.getImageName(forKey: imageId)
                let imageStorageRef = imagesStorageReference.child(event.uid).child(imageName)
                imageStorageRef.delete { (error) in
                    if let error = error {
                        completionHandler()
                        print("An error occupied while deleting an image: \(error)")
                    }
                }
            }
            
            var newImageIds: [String] = []
            for imageId in event.imageIDs {
                if oldImageIDs.firstIndex(of: imageId) != nil {
                    continue
                }
                newImageIds.append(imageId)
            }
            
            eventReference.setValue(dataDict) { (error, ref) in
                if let error = error {
                    completionHandler()
                    print(error)
                    return
                }
                guard let eventId = ref.key else {
                    completionHandler()
                    return
                }
                let imagesManager = ImagesManager.shared
                for imageId in newImageIds {
                    let imageName = SportEvent.getImageName(forKey: imageId)
                    let imageRef = imagesDatabaseReference.child(imageId)
                    imageRef.setValue(imageName)
                    let ref = imagesStorageReference.child(eventId).child(imageName)
                    if let image = ImagesManager.shared.getCachedImage(forName: imageName),
                       let data = image.pngData() {
                        let task = ref.putData(data)
                        imagesManager.appendUploadTask(task)
                    }
                }
            }
            completionHandler()
        }
    }
}
