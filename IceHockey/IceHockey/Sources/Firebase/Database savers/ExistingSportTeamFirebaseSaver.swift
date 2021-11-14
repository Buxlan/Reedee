//
//  ExistingSportTeamFirebaseSaver.swift
//  IceHockey
//
//  Created by  Buxlan on 10/30/21.
//

import Firebase

struct ExistingSportTeamFirebaseSaver: SportTeamFirebaseSaver {
    
    // MARK: - Properties
    typealias DataType = SportTeam
    internal let object: DataType
    
    internal var objectsDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("teams")
    }
    
    internal var imagesDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("images")
    }
    
    internal var imagesStorageReference: StorageReference {
        let ref = FirebaseManager.shared.storageManager.root.child("teams")
        return ref
    }
    
    internal var objectDatabaseReference: DatabaseReference {
        var ref: DatabaseReference
        if object.isNew {
            ref = objectsDatabaseReference.childByAutoId()
        } else {
            ref = objectsDatabaseReference.child(object.uid)
        }
        return ref
    }
    
    // MARK: - Lifecircle
    
    init(object: DataType) {
        self.object = object
    }
    
    // MARK: - Helper functions
    
    func performImageOperation(oldImageID: String, newImageID: String) {
        let imagesManager = ImagesManager.shared
        if !oldImageID.isEmpty
            && oldImageID != newImageID {
            // need to remove image from server
            let imageName = ImagesManager.shared.getImageName(withID: oldImageID)
            let imageStorageRef = imagesStorageReference.child(object.uid).child(imageName)
            imageStorageRef.delete { (error) in
                if let error = error {
                    print("An error occupied while deleting an image: \(error)")
                }
            }
        } else if oldImageID != newImageID {
            // need to append image
            let imageName = ImagesManager.shared.getImageName(withID: newImageID)
            let imageRef = imagesDatabaseReference.child(newImageID)
            imageRef.setValue(imageName)
            let imageStorageRef = imagesStorageReference.child(newImageID).child(imageName)
            if let image = ImagesManager.shared.getCachedImage(withName: imageName),
               let data = image.pngData() {
                let task = imageStorageRef.putData(data)
                imagesManager.appendUploadTask(task)
            }
        }
    }
    
    func save() throws {
        
        let dataDict = object.prepareDataForSaving()
        
        // get old data
        // compare and delete old images if needed
        objectDatabaseReference.getData { error, snapshot in
            if let error = error {
                print(error)
                return
            }
            guard let oldObject = DataType(snapshot: snapshot) else {
                return
            }
            performImageOperation(oldImageID: oldObject.smallImageID, newImageID: object.smallImageID)
            performImageOperation(oldImageID: oldObject.largeImageID, newImageID: object.largeImageID)
        }
        objectsDatabaseReference.setValue(dataDict) { (error, ref) in
            if let error = error {
                print(error)
                return
            }         
        }
    }
}
