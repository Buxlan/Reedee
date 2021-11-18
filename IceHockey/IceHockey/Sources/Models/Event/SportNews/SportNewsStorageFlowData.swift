//
//  SportNewsStorageFlowData.swift
//  IceHockey
//
//  Created by  Buxlan on 11/17/21.
//

import UIKit

protocol SportNewsStorageFlowData {
    var eventID: String { get set }
    var images: [ImageData] { get set }
    func load(with completionHandler: @escaping () -> Void)
}

struct DefaultSportNewsStorageFlowData: SportNewsStorageFlowData {
    var eventID: String
    var images: [ImageData]
    init() {
        images = []
        eventID = ""
    }
    func load(with completionHandler: @escaping () -> Void) {
    }
}

class SportNewsStorageFlowDataImpl: SportNewsStorageFlowData {
    
    // MARK: - Properties
    
    var eventID: String
    var images: [ImageData]
    private var imageIDs: [String]
    private var handlers: [String: (UIImage?) -> Void] = [:]
    
    private var path: String {
        return "events/\(eventID)"
    }
    
    // MARK: - Lifecircle
    
    init() {
        images = []
        imageIDs = []
        eventID = ""
    }
    
    required init(eventID: String, imageIDs: [String]) {
        images = []
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
            images.append(ImageData(imageID: imageID))
            let handler: (UIImage?) -> Void = { (image) in
                guard let image = image else {
                    return
                }
                let imageData = ImageData(imageID: imageID, image: image)
                if let index = self.images.firstIndex(where: { $0.imageID == imageID }) {
                    self.images[index] = imageData
                }
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
