//
//  SportNewsStorageFlowData.swift
//  IceHockey
//
//  Created by  Buxlan on 9/5/21.
//

import UIKit

protocol SportNews: SportEvent, SportNewsDatabaseFlowData {
    var author: SportUser? { get set }
    var mainImage: UIImage? { get }
    var images: [ImageData] { get set }
    var likesInfo: EventLikesInfo { get set }
    var viewsInfo: EventViewsInfo { get set }
    
    mutating func addImage(_ image: UIImage)
    mutating func removeImage(with imageID: String)
    func encode() -> [String: Any]
}

struct SportNewsImpl: SportNews {
    
    var viewsInfo: EventViewsInfo = EventViewsInfoImpl.empty
    var likesInfo: EventLikesInfo = EventLikesInfoImpl.empty
    var author: SportUser?
        
    var objectIdentifier: String {
        get { databaseFlowObject.objectIdentifier }
        set { databaseFlowObject.objectIdentifier = newValue }
    }
    
    var authorID: String {
        get { databaseFlowObject.authorID }
        set { databaseFlowObject.authorID = newValue }
    }
    
    var title: String {
        get { databaseFlowObject.title }
        set { databaseFlowObject.title = newValue }
    }
    
    var text: String {
        get { databaseFlowObject.text }
        set { databaseFlowObject.text = newValue }
    }
    
    var boldText: String {
        get { databaseFlowObject.boldText }
        set { databaseFlowObject.boldText = newValue }
    }
    
    var type: SportEventType {
        get { databaseFlowObject.type }
        set { databaseFlowObject.type = newValue }
    }
    
    var date: Date {
        get { databaseFlowObject.date }
        set { databaseFlowObject.date = newValue }
    }
    
    internal var imageIDs: [String] {
        get { databaseFlowObject.imageIDs }
        set { databaseFlowObject.imageIDs = newValue }
    }
    
    var order: Int {
        get { databaseFlowObject.order }
        set { databaseFlowObject.order = newValue }
    }
    
    var images: [ImageData] {
        get { return storageFlowObject.images }
        set { storageFlowObject.images = newValue }
    }
    
    private var databaseFlowObject: SportNewsDatabaseFlowData
    private var storageFlowObject: StorageFlowData
    
    init(databaseFlowObject: SportNewsDatabaseFlowData = EmptySportNewsDatabaseFlowData(),
         storageFlowObject: StorageFlowData = EmptyStorageFlowData(),
         author: SportUser? = nil,
         likesInfo: EventLikesInfo = EventLikesInfoImpl.empty,
         viewsInfo: EventViewsInfo = EventViewsInfoImpl.empty) {
        self.databaseFlowObject = databaseFlowObject
        self.storageFlowObject = storageFlowObject
        self.likesInfo = likesInfo
        self.viewsInfo = viewsInfo
        self.author = author
    }
    
}

extension SportNewsImpl {
    
    var mainImage: UIImage? {
        if images.count > 0 {
            return images[0].image
        }
        return nil
    }
    
    mutating func updateImages(images: [ImageData]) {
        self.images = images
    }
    
    mutating func addImage(_ image: UIImage) {
        let image = image.resizeImage(to: 512, aspectRatio: .square)
        let imageData = ImageData(image: image, isNew: true)
        images.append(imageData)
    }
    
    mutating func removeImage(with imageID: String) {
        if let index = images.firstIndex(where: { $0.imageID == imageID }) {
            images[index].isRemoved = true
        }
    }
    
    func encode() -> [String: Any] {
        
        var imagesID: [String] = []
        self.images.forEach { imageData in
            guard !imageData.isRemoved,
                  imageData.image != nil else {
                return
            }
            imagesID.append(imageData.imageID)
        }
        
        let interval = date.timeIntervalSince1970
        let dict: [String: Any] = [
            "uid": objectIdentifier,
            "author": authorID,
            "title": title,
            "text": text,
            "boldText": boldText,
            "type": type.rawValue,
            "date": Int(interval),
            "images": imagesID,
            "order": order
        ]
        return dict
    }
    
    func save(completionHandler: @escaping (SportEventSaveError?) -> Void) {
        SportNewsFirebaseSaver(object: self).save(completionHandler: completionHandler)
    }
    
}
