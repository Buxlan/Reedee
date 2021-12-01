//
//  FirebaseImagesLoader.swift
//  IceHockey
//
//  Created by  Buxlan on 11/23/21.
//

import Firebase

protocol FirebaseImagesLoader: FirebaseLoader {
    var objectIdentifier: String { get }
    var imagesPath: String { get }
    func load(completionHandler: @escaping (StorageFlowData?) -> Void)
}

class FirebaseImagesLoaderImpl {
    
    // MARK: - Properties
    
    let objectIdentifier: String
    
    private var imagesPath: String
    private var handlers: [String: (UIImage?) -> Void] = [:]
    private var imagesIdentifiers: [String]
    
    // MARK: - Lifecircle
    
    init(objectIdentifier: String,
         imagesIdentifiers: [String],
         imagesPath: String) {
        self.objectIdentifier = objectIdentifier
        self.imagesIdentifiers = imagesIdentifiers
        self.imagesPath = imagesPath
    }
    
    func load(completionHandler: @escaping (StorageFlowData?) -> Void) {
        guard !objectIdentifier.isEmpty,
              !imagesIdentifiers.isEmpty else {
            completionHandler(nil)
            return
        }
        handlers.removeAll()
        var images: [ImageData] = []
        imagesIdentifiers.forEach { [weak self] imageID in
            guard let self = self else { return }
            if imageID.isEmpty {
                return
            }
            images.append(ImageData(imageID: imageID))
            let handler: (UIImage?) -> Void = { [weak self] (image) in
                guard let self = self else {
                    return
                }
                if let index = self.handlers.index(forKey: imageID) {
                    self.handlers.remove(at: index)
                }
                if let image = image,
                   let index = images.firstIndex(where: { $0.imageID == imageID }) {
                    let imageData = ImageData(imageID: imageID, image: image)
                    images[index] = imageData
                }
                if self.handlers.count == 0 {
                    let object = StorageFlowDataImpl(objectIdentifier: self.objectIdentifier,
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
