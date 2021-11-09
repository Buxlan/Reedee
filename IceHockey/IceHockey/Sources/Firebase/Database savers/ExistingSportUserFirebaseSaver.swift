//
//  ExistingSportUserFirebaseSaver.swift
//  IceHockey
//
//  Created by  Buxlan on 11/9/21.
//

import Firebase

struct ExistingSportUserFirebaseSaver: SportUserFirebaseSaver {
    
    // MARK: - Properties
    typealias DataType = SportUser
    internal let object: DataType
    
    internal var eventsDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("users")
    }
    
    internal var imagesDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("images")
    }
    
    internal var imagesStorageReference: StorageReference {
        let ref = FirebaseManager.shared.storageManager.root.child("users")
        return ref
    }
    
    internal var eventReference: DatabaseReference {
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
        
        eventReference.setValue(dataDict) { error, ref in
            if let error = error {
                print("Saving error: \(error)")
                return
            }
            
            guard let objectId = ref.key else {
                return
            }            
            let imagesManager = ImagesManager.shared
            let imageName = ImagesManager.getImageName(forKey: object.imageID)
            let imageRef = imagesDatabaseReference.child(object.imageID)
            imageRef.setValue(imageName)
            let ref = imagesStorageReference.child(objectId).child(imageName)
            if let image = ImagesManager.shared.getCachedImage(forName: imageName),
               let data = image.pngData() {
                let task = ref.putData(data)
                imagesManager.appendUploadTask(task)
            }
        }
    }
}
