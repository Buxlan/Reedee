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
}

class SportNewsProxy: SportNews {
    
    var event: SportNews? {
        didSet {
            loadingCompletionHandler()
            loadingCompletionHandler = {}
        }
    }
    var loadingCompletionHandler: () -> Void = {}
    
    var likesInfo: EventLikesInfo {
        get { event?.likesInfo ?? EventLikesInfoImpl.empty }
        set { event?.likesInfo = newValue }
    }
    var viewsInfo: EventViewsInfo {
        get { event?.viewsInfo ?? EventViewsInfoImpl.empty }
        set { event?.viewsInfo = newValue }
    }
        
    var objectIdentifier: String {
        get { event?.objectIdentifier ?? "" }
        set { event?.objectIdentifier = newValue }
    }
    var authorID: String {
        get { event?.authorID ?? "" }
        set { event?.authorID = newValue }
    }
    var author: SportUser? {
        get { event?.author }
        set { event?.author = newValue }
    }
    var title: String {
        get { event?.title ?? "" }
        set { event?.title = newValue }
    }
    var text: String {
        get { event?.text ?? "" }
        set { event?.text = newValue }
    }
    var boldText: String {
        get { event?.boldText ?? "" }
        set { event?.boldText = newValue }
    }
    var type: SportEventType {
        get { event?.type ?? .event }
        set { event?.type = newValue }
    }
    var date: Date {
        get { event?.date ?? Date() }
        set { event?.date = newValue }
    }
    internal var imageIDs: [String] {
        get { event?.imageIDs ?? [] }
        set { event?.imageIDs = newValue }
    }
    var order: Int {
        get { event?.order ?? 0 }
        set { event?.order = newValue }
    }
    var images: [ImageData] {
        get { return event?.images ?? [] }
        set { event?.images = newValue }
    }
    var mainImage: UIImage? {
        return event?.mainImage        
    }
    
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
