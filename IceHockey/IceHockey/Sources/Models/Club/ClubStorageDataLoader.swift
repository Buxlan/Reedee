//
//  ClubStorageDataLoader.swift
//  IceHockey
//
//  Created by  Buxlan on 11/22/21.
//

import Firebase

class ClubStorageDataLoader {
    
    // MARK: - Properties
    
    let objectIdentifier: String
    typealias DataType = ClubStorageFlowData
    typealias DataTypeImpl = ClubStorageFlowDataImpl
    
    private lazy var imagesPath: String =  "teams/\(objectIdentifier)"
    private var handlers: [String: (UIImage?) -> Void] = [:]
    private var imagesIdentifiers: [String]
    
    // MARK: - Lifecircle
    
    init(objectIdentifier: String, imagesIdentifiers: [String]) {
        self.objectIdentifier = objectIdentifier
        self.imagesIdentifiers = imagesIdentifiers
    }
    
    func load(completionHandler: @escaping (DataType?) -> Void) {
        guard !objectIdentifier.isEmpty else {
            completionHandler(nil)
            return
        }
        handlers.removeAll()
        var images: [ImageData] = []
        imagesIdentifiers.forEach { imageID in
            if imageID.isEmpty {
                return
            }
            images.append(ImageData(imageID: imageID))
            let handler: (UIImage?) -> Void = { (image) in
                if let index = self.handlers.index(forKey: imageID) {
                    self.handlers.remove(at: index)
                }
                if let image = image,
                   let index = images.firstIndex(where: { $0.imageID == imageID }) {
                    let imageData = ImageData(imageID: imageID, image: image)
                    images[index] = imageData                    
                }
                
                if self.handlers.count == 0 {
                    let object = DataTypeImpl(objectIdentifier: self.objectIdentifier,
                                              images: images)
                    completionHandler(object)
                }
            }
            handlers[imageID] = handler
        }
        imagesIdentifiers.forEach { imageID in
            if imageID.isEmpty {
                return
            }
            if let handler = handlers[imageID] {
                ImagesManager.shared.getImage(withID: imageID, path: imagesPath, completion: handler)
            }
        }
    }
    
}
