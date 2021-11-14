//
//  HockeyEvent.swift
//  IceHockey
//
//  Created by  Buxlan on 9/5/21.
//

import UIKit
import Firebase

struct SportNews: SportEvent, Hashable {
    
    var uid: String
    var author: String
    var title: String
    var text: String
    var boldText: String
    var type: SportEventType
    var date: Date
    var imageIDs: [String] = []
    var order: Int
    
    init(uid: String,
         author: String,
         title: String,
         text: String,
         boldText: String,
         imageIDs: [String],
         date: Date,
         type: SportEventType = .event,
         order: Int) {
        self.uid = uid
        self.author = author
        self.title = title
        self.text = text
        self.date = date
        self.type = type
        self.boldText = boldText
        self.imageIDs = imageIDs
        self.order = order
    }
    
    internal init() {
        self.uid = ""
        self.title = .empty
        self.text = .empty
        self.date = Date()
        self.type = .event
        self.boldText = ""
        self.imageIDs = []
        self.order = 0
        self.author = Auth.auth().currentUser?.uid ?? ""
    }    
    
    init?(key: String, dict: [String: Any]) {
        guard let text = dict["text"] as? String,
              let author = dict["author"] as? String,
              let boldText = dict["boldText"] as? String,
              let title = dict["title"] as? String,
              let rawType = dict["type"] as? Int,
              let type = SportEventType(rawValue: rawType),
              let dateInterval = dict["date"] as? Int,
              let order = dict["order"] as? Int else { return nil }
                
        self.uid = key
        self.author = author
        self.text = text
        self.title = title
        self.date = Date(timeIntervalSince1970: TimeInterval(dateInterval))
        self.imageIDs = dict["images"] as? [String] ?? []
        self.type = type
        self.boldText = boldText
        self.order = order
    }
    
    init?(snapshot: DataSnapshot) {
        let uid = snapshot.key
        guard let dict = snapshot.value as? [String: Any] else {
            return nil
        }
        self.init(key: uid, dict: dict)
    }
    
}

extension SportNews: FirebaseObject {    
    
    private static var databaseObjects: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("events")
    }
    
    var isNew: Bool {
        return self.uid.isEmpty
    }
    
    var mainImageID: String? {
        if imageIDs.count > 0 {
            return imageIDs[0]
        }
        return nil
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
                    fatalError("Current team is nil")
                }
                let team = Self(snapshot: snapshot)
                handler(team)
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
            try ExistingSportNewsFirebaseSaver(object: self).save()
        } else {
            try NewSportNewsFirebaseSaver(object: self).save()
        }
    }
    
    func prepareDataForSaving() -> [String: Any] {
        let interval = self.date.timeIntervalSince1970
        let dict: [String: Any] = [
            "uid": self.uid,
            "author": self.author,
            "title": self.title,
            "text": self.text,
            "boldText": self.boldText,
            "type": self.type.rawValue,
            "date": Int(interval),
            "images": self.imageIDs,
            "order": Int(order)
        ]
        return dict
    }
    
}

extension SportNews {
    
    mutating func appendImage(_ image: UIImage) {
        if let key = FirebaseManager.shared.databaseManager.getNewImageUID() {
            let imageName = ImagesManager.shared.getImageName(withID: key)
            ImagesManager.shared.appendToCache(image, for: imageName)
            imageIDs.append(key)
        }
    }
    
    mutating func removeImage(withID imageID: String) {
        guard let index = imageIDs.firstIndex(of: imageID) else {
            return
        }
        let imageName = ImagesManager.shared.getImageName(withID: imageID)
        ImagesManager.shared.removeFromCache(imageForKey: imageName)
        imageIDs.remove(at: index)
    }
    
}
