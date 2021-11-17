//
//  SportNewsStorageFlowData.swift
//  IceHockey
//
//  Created by  Buxlan on 9/5/21.
//

import UIKit

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
    
    var images: [ImageData] {
        return storageFlowObject.images
    }
    
    private var databaseFlowObject: SportNewsDatabaseFlowData
    private var storageFlowObject: SportNewsStorageFlowData
    
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
        if storageFlowObject.images.count > 0 {
            return storageFlowObject.images[0].image
        }
        return nil
    }
        
    mutating func appendImage(_ image: UIImage) {
        let imageData = ImageData(image: image)
        storageFlowObject.images.append(imageData)
    }

    mutating func removeImage(withID imageID: String) {
        let index = storageFlowObject.images.firstIndex {
            $0.imageID == imageID
        }
        if let index = index {
            storageFlowObject.images.remove(at: index)
        }
    }
    
    mutating func updateImages(images: [ImageData]) {
        storageFlowObject.images = images
    }
    
}
