//
//  HockeyEvent.swift
//  IceHockey
//
//  Created by  Buxlan on 9/5/21.
//

import UIKit
import Firebase

protocol SportNewsDatabaseFlowData: SportEvent {
    var uid: String { get set }
    var author: String { get set }
    var title: String { get set }
    var text: String { get set }
    var boldText: String { get set }
    var type: SportEventType { get set }
    var date: Date { get set }
    var imageIDs: [String] { get set }
    var order: Int { get set }
}

struct SportNewsDatabaseFlowDataImpl: SportNewsDatabaseFlowData {
    var uid: String
    var author: String
    var title: String
    var text: String
    var boldText: String
    var type: SportEventType
    var date: Date
    internal var imageIDs: [String] = []
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
        self.author = ""
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
    
}

protocol SportNewsStorageFlowData {
    var eventID: String { get set }
    var images: [String: ImageData] { get set }
    init(eventID: String, imageIDs: [String])
    func load(with completionHandler: @escaping () -> Void)
}

class SportNewsStorageFlowDataImpl: SportNewsStorageFlowData {
    
    // MARK: - Properties
    
    var eventID: String
    var images: [String: ImageData]
    private var imageIDs: [String]
    private var handlers: [String: (UIImage?) -> Void] = [:]
    
    private var path: String {
        return "events/\(eventID)"
    }
    
    // MARK: - Lifecircle
    
    init() {
        images = [:]
        imageIDs = []
        eventID = ""
    }
    
    required init(eventID: String, imageIDs: [String]) {
        images = [:]
        self.imageIDs = imageIDs
        self.eventID = eventID
    }
    
    // MARK: - Helper methods
    
    func load(with completionHandler: @escaping () -> Void) {
        handlers.removeAll()
        imageIDs.forEach { imageID in
            if imageID.isEmpty {
                return
            }
            images[imageID] = ImageData()
            let handler: (UIImage?) -> Void = { (image) in
                guard let image = image else {
                    return
                }
                let imageData = ImageData(imageID: imageID, image: image)
                self.images[imageID] = imageData
                if let index = self.handlers.index(forKey: imageID) {
                    self.handlers.remove(at: index)
                }
                if self.handlers.count == 0 {
                    completionHandler()
                }
            }
            handlers[imageID] = handler
        }
        imageIDs.forEach { imageID in
            if imageID.isEmpty {
                return
            }
            if let handler = handlers[imageID] {
                ImagesManager.shared.getImage(withID: imageID, path: path, completion: handler)
            }
        }
    }
}

struct SportNews: SportNewsDatabaseFlowData {
        
    var uid: String {
        get {
            databaseFlowObject.uid
        }
        set {
            databaseFlowObject.uid = newValue
        }
    }
    
    var author: String {
        get {
            databaseFlowObject.author
        }
        set {
            databaseFlowObject.author = newValue
        }
    }
    
    var title: String {
        get {
            databaseFlowObject.title
        }
        set {
            databaseFlowObject.title = newValue
        }
    }
    
    var text: String {
        get {
            databaseFlowObject.text
        }
        set {
            databaseFlowObject.text = newValue
        }
    }
    
    var boldText: String {
        get {
            databaseFlowObject.boldText
        }
        set {
            databaseFlowObject.boldText = newValue
        }
    }
    
    var type: SportEventType {
        get {
            databaseFlowObject.type
        }
        set {
            databaseFlowObject.type = newValue
        }
    }
    
    var date: Date {
        get {
            databaseFlowObject.date
        }
        set {
            databaseFlowObject.date = newValue
        }
    }
    
    internal var imageIDs: [String] {
        get {
            databaseFlowObject.imageIDs
        }
        set {
            databaseFlowObject.imageIDs = newValue
        }
    }
    
    var order: Int {
        get {
            databaseFlowObject.order
        }
        set {
            databaseFlowObject.order = newValue
        }
    }
    
    var images: [String: ImageData] {
        return storageFlowObject.images
    }
    
    var databaseFlowObject: SportNewsDatabaseFlowData
    var storageFlowObject: SportNewsStorageFlowData
    
    init() {
        self.databaseFlowObject = SportNewsDatabaseFlowDataImpl()
        self.storageFlowObject = SportNewsStorageFlowDataImpl()
    }
    
    init(databaseFlowObject: SportNewsDatabaseFlowData, storageFlowObject: SportNewsStorageFlowData) {
        self.databaseFlowObject = databaseFlowObject
        self.storageFlowObject = storageFlowObject
    }
    
}

extension SportNews {
    
    var isNew: Bool {
        return databaseFlowObject.uid.isEmpty
    }
    
    var mainImage: UIImage? {
        let images = storageFlowObject.images
        if let (_, value) = images.first {            
            return value.image
        }
        return nil
    }
        
//    mutating func appendImage(_ image: UIImage) {
//        let imageData = ImageData(image: image)
//        storageFlowObject.images.append(imageData)
//    }
//
//    mutating func removeImage(withID imageID: String) {
//        let index = storageFlowObject.images.firstIndex {
//            $0.imageID == imageID
//        }
//        if let index = index {
//            storageFlowObject.images.remove(at: index)
//        }
//    }
    
    mutating func updateImages(images: [String: ImageData]) {
        storageFlowObject.images = images
    }
    
}
