//
//  HockeyEvent.swift
//  IceHockey
//
//  Created by  Buxlan on 9/5/21.
//

import UIKit
import Firebase

struct SportEvent: Hashable {
    var uid: String
    var title: String
    var text: String
    var boldText: String
    var actionTitle: String?
    var viewsCount: Int?
    var type: SportEventType
    var date: Date
    var imageIDs: [String] = []
    var order: Int
    
    init(uid: String,
         title: String,
         text: String,
         boldText: String,
         imagesNames: [String],
         actionTitle: String? = nil,
         date: Date,
         type: SportEventType = .match,
         order: Int) {
        self.uid = uid
        self.title = title
        self.text = text
        self.viewsCount = Int.random(in: 1...10000)
        self.actionTitle = actionTitle
        self.date = date
        self.type = type
        self.boldText = boldText
        self.imageIDs = imagesNames
        self.order = order
    }
    
    internal init() {
        self.uid = ""
        self.title = .empty
        self.text = .empty
        self.actionTitle = nil
        self.viewsCount = 123
        self.viewsCount = Int.random(in: 1...10000)
        self.date = Date()
        self.type = .event
        self.boldText = ""
        self.imageIDs = []
        self.order = 0
    }
    
    init?(snapshot: DataSnapshot) {
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else { return nil }
        guard let text = dict["text"] as? String else { return nil }
        guard let boldText = dict["boldText"] as? String else { return nil }
        guard let title = dict["title"] as? String else { return nil }
        guard let rawType = dict["type"] as? Int,
              let type = SportEventType(rawValue: rawType) else { return nil }
        guard let dateInterval = dict["date"] as? Int else { return nil }
        guard let order = dict["type"] as? Int else { return nil }
                
        self.uid = uid
        self.text = text
        self.title = title
        self.date = Date(timeIntervalSince1970: TimeInterval(dateInterval))
        self.imageIDs = dict["images"] as? [String] ?? []
        self.type = type
        self.boldText = boldText
        self.order = order
    }
    
}

extension SportEvent {
    
    var eventsDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("events")
    }
    
    var imagesDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("images")
    }
    
    var imagesStorageReference: StorageReference {
        let ref = FirebaseManager.shared.storageManager.root.child("events")
        return ref
    }
    
    var eventReference: DatabaseReference {
        var ref: DatabaseReference
        if isNew {
            ref = eventsDatabaseReference.childByAutoId()
        } else {
            ref = eventsDatabaseReference.child(uid)
        }
        return ref
    }
    
    func checkProperties() -> Bool {
        return true
    }
    
    func save() throws {
        
        if !checkProperties() {
            print("Error. Properties are wrong")
        }
        
        // for order purposes
        var dateComponent = DateComponents()
        dateComponent.calendar = Calendar.current
        dateComponent.year = 2024
        guard let templateDate = dateComponent.date else {
            fatalError()
        }
        
        let order = templateDate.timeIntervalSince(self.date)
        var dict = valuesDictionary
        dict["order"] = Int(order)
        
        if isNew {
            saveNewEvent(values: valuesDictionary)
        } else {
            saveExistingEvent(values: valuesDictionary)
        }
    }
    
    var valuesDictionary: [String: Any] {
        let interval = self.date.timeIntervalSince1970
        let dict: [String: Any] = [
            "uid": self.uid,
            "title": self.title,
            "text": self.text,
            "boldText": self.boldText,
            "actionTitle": self.actionTitle ?? "",
            "viewsCount": self.viewsCount ?? 0,
            "type": self.type.rawValue,
            "date": Int(interval),
            "images": self.imageIDs,
            "order": Int(order)
        ]
        return dict
    }
    
    private func saveExistingEvent(values: [String: Any]) {
        eventReference.child("images").getData { (error, snapshot) in
            if let error = error {
                print(error)
                return
            }
            let oldImageIDs = snapshot.value as? [String] ?? []
            
            for imageId in oldImageIDs {
                if self.imageIDs.firstIndex(of: imageId) != nil {
                    continue
                }
                // need to remove image from storage
                let imageName = SportEvent.getImageName(forKey: imageId)
                let imageStorageRef = imagesStorageReference.child(uid).child(imageName)
                imageStorageRef.delete { (error) in
                    if let error = error {
                        print("An error occupied while deleting an image: \(error)")
                    }
                }
            }
            
            var newImageIds: [String] = []
            for imageId in self.imageIDs {
                if oldImageIDs.firstIndex(of: imageId) != nil {
                    continue
                }
                newImageIds.append(imageId)
            }
            
            eventReference.setValue(values) { (error, ref) in
                if let error = error {
                    print(error)
                    return
                }
                guard let eventId = ref.key else {
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
        }
    }
    
    private func saveNewEvent(values: [String: Any]) {
        eventReference.setValue(values) { (error, ref) in
            if let error = error {
                print(error)
                return
            }
            guard let eventId = ref.key else { return }
            let imagesManager = ImagesManager.shared
            for imageId in imageIDs {
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
    }
    
    var isNew: Bool {
        return self.uid.isEmpty
    }
    
    var mainImageName: String? {
        if imageIDs.count > 0 {
            return SportEvent.getImageName(forKey: imageIDs[0])
        }
        return nil
    }
    
}

extension SportEvent {
    
    mutating func appendImage(_ image: UIImage) {
        if let key = FirebaseManager.shared.databaseManager.getNewImageUID() {
            let imageName = SportEvent.getImageName(forKey: key)
            ImagesManager.shared.appendToCache(image, for: imageName)
            imageIDs.append(key)
        }
    }
    
    mutating func removeImage(withName imageID: String) {
        guard let index = imageIDs.firstIndex(of: imageID) else {
            return
        }
        let imageName = SportEvent.getImageName(forKey: imageID)
        ImagesManager.shared.removeFromCache(imageForKey: imageName)
        imageIDs.remove(at: index)
    }
    
    static func getImageName(forKey key: String) -> String {
        return key + ".png"
    }
    
}
