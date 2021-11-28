//
//  SportNewsProxy.swift
//  IceHockey
//
//  Created by  Buxlan on 11/28/21.
//

import UIKit

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

extension SportNewsProxy {
    
    func addImage(_ image: UIImage) {
        event?.addImage(image)
    }
    
    func removeImage(with imageID: String) {
        event?.removeImage(with: imageID)
    }
    
    func encode() -> [String: Any] {
        if let event = event {
            return event.encode()
        } else {
            return [:]
        }
    }
    
    func save(completionHandler: @escaping (SportEventSaveError?) -> Void) {
        event?.save(completionHandler: completionHandler)
    }
    
}
