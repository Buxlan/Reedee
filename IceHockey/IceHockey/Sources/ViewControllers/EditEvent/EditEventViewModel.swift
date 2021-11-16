//
//  EditEventViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 10/20/21.
//

import UIKit

struct ImageData: Hashable {
    var imageID: String?
    var image: UIImage = UIImage()
    var isNew: Bool = false
    var isRemoved: Bool = false
}

struct ImageList {
    
    var data: [ImageData] = []
    
    subscript(index: Int) -> ImageData {
        assert(index > 0 && index < data.count)
        return data[index]
    }
    
    mutating func append(_ newElement: ImageData) {
        data.append(newElement)
    }
    
    mutating func remove(at index: Int) {
        assert(index > 0 && index < data.count)
        data.remove(at: index)
    }
    
    mutating func firstIndex(where predicate: (ImageData) throws -> Bool) throws -> Int? {
        try data.firstIndex(where: predicate)
    }
    
}

class EditEventViewModel {
    
    // MARK: - Propetries
    
    var event: SportNews
    var shouldReloadRelay = {}
    var collectionViewDataSource = CollectionDataSource()
    
    var unremovedImageList: [ImageData] {
        imageList.filter { imageData in
            !imageData.isRemoved
        }
    }
    private var imageList: [ImageData] = []      
    private var loadingHandlers: [String: (UIImage?) -> Void] = [:]
    
    init(event: SportNews) {
        self.event = event
    }
}

extension EditEventViewModel {
    
    // MARK: - Helper methods
    
    func appendImage(_ image: UIImage) {
        let image = image.resizeImage(to: 512, aspectRatio: .square)
        let imageData = ImageData(image: image, isNew: true)
        self.imageList.append(imageData)
        self.shouldReloadRelay()
    }
    
    func removeImage(_ image: UIImage) {
        if let index = imageList.firstIndex(where: { $0.image == image }) {
            imageList[index].isRemoved = true
            self.shouldReloadRelay()
        }
    }
    
    func loadImagesIfNeeded(event: SportNews) {
        if imageList.count > 0 {
            return
        }
        let eventID = event.uid
        guard !eventID.isEmpty else {
            return
        }
        imageList.removeAll()
        loadingHandlers.removeAll()
        let path = "events/\(eventID)"
        
        DispatchQueue.global(qos: .userInitiated).async {
            event.imageIDs.forEach { imageID in
                let handler: (UIImage?) -> Void = { image in
                    if let image = image {
                        let imageData = ImageData(imageID: imageID, image: image)
                        self.imageList.append(imageData)
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
    
    func save() throws {
//        event.save()
    }
    
    func makeEventForSaving() -> SportNews {
        return event
    }
    
}
