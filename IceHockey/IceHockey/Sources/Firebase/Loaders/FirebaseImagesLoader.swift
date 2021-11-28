//
//  FirebaseImagesLoader.swift
//  IceHockey
//
//  Created by  Buxlan on 11/23/21.
//

import Firebase

protocol FirebaseImagesLoader {
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
                    let object = StorageFlowDataImpl(objectIdentifier: self.objectIdentifier,
                                              images: images)
                    if let index = images.firstIndex(where: { imageData in
                        imageData.imageID == "-Mpaee-jW90OK2r4q0W8"
                    }) {
                        print("-Mpaee-jW90OK2r4q0W8 HEREE!")
                    }
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
