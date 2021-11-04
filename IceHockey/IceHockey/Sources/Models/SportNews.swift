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
         imageIDs: [String],
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
        self.imageIDs = imageIDs
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
    
    init?(key: String, dict: [String: Any]) {
        guard let text = dict["text"] as? String,
              let boldText = dict["boldText"] as? String,
              let title = dict["title"] as? String,
              let rawType = dict["type"] as? Int,
              let type = SportEventType(rawValue: rawType),
              let dateInterval = dict["date"] as? Int,
              let order = dict["order"] as? Int else { return nil }
                
        self.uid = key
        self.text = text
        self.title = title
        self.date = Date(timeIntervalSince1970: TimeInterval(dateInterval))
        self.imageIDs = dict["images"] as? [String] ?? []
        self.type = type
        self.boldText = boldText
        self.order = order
    }
    
}

extension SportNews {
    
    var isNew: Bool {
        return self.uid.isEmpty
    }
    
    var mainImageID: String? {
        if imageIDs.count > 0 {
            return ImagesManager.getImageName(forKey: imageIDs[0])
        }
        return nil
    }
        
    func checkProperties() -> Bool {
        return true
    }
    
    func save() throws {
        
        if !checkProperties() {
            print("Error. Properties are wrong")
        }
        
        if isNew {
            try ExistingSportEventFirebaseSaver(object: self).save {
                print("!!!existing ok!!!")
            }
        } else {
            try NewSportEventFirebaseSaver(object: self).save {
                print("!!!new ok!!!")
            }
        }
    }
    
    func prepareDataForSaving() -> [String: Any] {
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
    
}

extension SportNews {
    
    mutating func appendImage(_ image: UIImage) {
        if let key = FirebaseManager.shared.databaseManager.getNewImageUID() {
            let imageName = ImagesManager.getImageName(forKey: key)
            ImagesManager.shared.appendToCache(image, for: imageName)
            imageIDs.append(key)
        }
    }
    
    mutating func removeImage(withName imageID: String) {
        guard let index = imageIDs.firstIndex(of: imageID) else {
            return
        }
        let imageName = ImagesManager.getImageName(forKey: imageID)
        ImagesManager.shared.removeFromCache(imageForKey: imageName)
        imageIDs.remove(at: index)
    }
    
}
