//
//  SportUser.swift
//  IceHockey
//
//  Created by  Buxlan on 11/9/21.
//

import UIKit
import Firebase

struct SportUser: Hashable {
    
    var uid: String
    var displayName: String
    var imageID: String
    
    init(uid: String,
         displayName: String,
         imageID: String) {
        self.uid = uid
        self.displayName = displayName
        self.imageID = imageID
    }
    
    internal init() {
        self.uid = ""
        self.displayName = ""
        self.imageID = ""
    }
    
    init?(key: String, dict: [String: Any]) {
        guard let displayName = dict["displayName"] as? String,
              let imageID = dict["image"] as? String else { return nil }
                
        self.uid = key
        self.displayName = displayName
        self.imageID = imageID
    }
    
    init?(snapshot: DataSnapshot) {
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else {
            return nil
        }
        self.init(key: uid, dict: dict)
    }
    
}

extension SportUser: FirebaseObject {
    
    private static var databaseObjects: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("users")
    }
    
    var isNew: Bool {
        return self.uid.isEmpty
    }
    
    func delete() throws {
        try FirebaseManager.shared.delete(self)
    }
    
    static func getObject(by uid: String, completionHandler handler: @escaping (Self?) -> Void) {
        Self.databaseObjects
            .child(uid)
            .getData { error, snapshot in
                if let error = error {
                    print(error)
                    return
                }
                if snapshot.value is NSNull {
                    fatalError()
                }
                let object = Self(snapshot: snapshot)
                handler(object)
            }
    }
    
    func checkProperties() -> Bool {
        return true
    }
    
    func save() throws {
        
        if !checkProperties() {
            print("Error. Properties are wrong")
        }
        
        if isNew {
            try ExistingSportUserFirebaseSaver(object: self).save()
        } else {
            try NewSportUserFirebaseSaver(object: self).save()
        }
    }
    
    func prepareDataForSaving() -> [String: Any] {
        let dict: [String: Any] = [
            "uid": self.uid,
            "displayName": self.displayName,
            "image": self.imageID
        ]
        return dict
    }
    
}

extension SportUser {
    
    mutating func appendImage(_ image: UIImage) {
        if let key = FirebaseManager.shared.databaseManager.getNewImageUID() {
            let imageName = ImagesManager.getImageName(forKey: key)
            ImagesManager.shared.appendToCache(image, for: imageName)
            self.imageID = key
        }
    }
    
    mutating func removeImage(withName imageID: String) {
        guard self.imageID == imageID else {
            return
        }
        let imageName = ImagesManager.getImageName(forKey: imageID)
        ImagesManager.shared.removeFromCache(imageForKey: imageName)
        self.imageID = ""
    }
    
}
