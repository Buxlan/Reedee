//
//  EditEventViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 10/20/21.
//

import UIKit

//struct ImageList {
//    
//    var data: [ImageData] = []
//    
//    subscript(index: Int) -> ImageData {
//        assert(index > 0 && index < data.count)
//        return data[index]
//    }
//    
//    mutating func append(_ newElement: ImageData) {
//        data.append(newElement)
//    }
//    
//    mutating func remove(at index: Int) {
//        assert(index > 0 && index < data.count)
//        data.remove(at: index)
//    }
//    
//    mutating func firstIndex(where predicate: (ImageData) throws -> Bool) throws -> Int? {
//        try data.firstIndex(where: predicate)
//    }
//    
//}

class EditEventViewModel {
    
    // MARK: - Propetries
    
    weak var eventProxy: SportNewsProxy? {
        didSet {
            guard let event = eventProxy?.event else {
                return
            }
            self.event = event
        }
    }
    var event: SportNews = SportNewsImpl()
    var shouldReloadRelay = {}
    var collectionViewDataSource = CollectionDataSource()
    var wasEdited: Bool = false
    
    var unremovedImages: [ImageData] {
        event.images.filter { imageData in
            !imageData.isRemoved
        }
    }
    private var loadingHandlers: [String: (UIImage?) -> Void] = [:]
    
    init(event: SportNews) {
        self.event = event
    }
    
    deinit {
        print("!!!! deinit!")
    }
    
}

extension EditEventViewModel {
    
    // MARK: - Helper methods
    
    func appendImage(_ image: UIImage) {
        event.addImage(image)
        self.shouldReloadRelay()
    }
    
    func removeImage(_ imageID: String) {
        event.removeImage(with: imageID)
        self.shouldReloadRelay()
    }    
        
    func save(completionHandler: (SportEventSaveError?) -> Void) {
        event.save(completionHandler: completionHandler)
    }
    
    func makeEventForSaving() -> SportNews {
        return event
    }
    
}
