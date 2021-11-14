//
//  EditEventViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 10/20/21.
//

import UIKit

class EditEventViewModel {
    var shouldReloadRelay = {}
    var images: [UIImage] = []
    var collectionViewDataSource = CollectionDataSource()
    
    func appendImage(_ image: UIImage) {
        let image = image.resizeImage(to: 512, aspectRatio: .square)
        self.images.append(image)
        self.shouldReloadRelay()
    }
    
    func removeImage(_ image: UIImage) {
        if let index = images.firstIndex(where: { $0 == image }) {
            images.remove(at: index)
            self.shouldReloadRelay()
        }
    }
      
    private var loadingHandlers: [String: (UIImage?) -> Void] = [:]
}

extension EditEventViewModel {
    
    func loadImagesIfNeeded(event: SportNews) {
        if images.count > 0 {
            return
        }
        let eventID = event.uid
        guard !eventID.isEmpty else {
            return
        }
        images.removeAll()
        loadingHandlers.removeAll()
        let path = "events/\(eventID)"
        
        DispatchQueue.global(qos: .userInitiated).async {
            event.imageIDs.forEach { imageID in
                let handler: (UIImage?) -> Void = { image in
                    if let image = image {
                        self.images.append(image)
                    }
                    if let index = self.loadingHandlers.index(forKey: imageID) {
                        self.loadingHandlers.remove(at: index)
                    }
                    if self.loadingHandlers.count == 0 {
                        DispatchQueue.main.async {
                            self.shouldReloadRelay()
                        }
                    }
                }
                self.loadingHandlers[imageID] = handler
            }
            event.imageIDs.forEach { imageID in
                ImagesManager.shared.getImage(withID: imageID, path: path) { (image) in
                    self.loadingHandlers[imageID]?(image)
                }
            }
        }
        
    }
    
}
