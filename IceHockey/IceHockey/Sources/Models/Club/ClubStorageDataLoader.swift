//
//  ClubStorageDataLoader.swift
//  IceHockey
//
//  Created by  Buxlan on 11/22/21.
//

import Firebase

class ClubStorageDataLoader: FirebaseLoader {
    
    // MARK: - Properties
    
    let objectIdentifier: String
    typealias DataType = StorageFlowData
    typealias DataTypeImpl = StorageFlowDataImpl
    
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
        for imageID in imagesIdentifiers {
            if imageID.isEmpty {
                return
            }
            images.append(ImageData(imageID: imageID))
            let handler: (UIImage?) -> Void = { [weak self] (image) in
                guard let self = self else { return }
                self.handlers[imageID] = nil
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
