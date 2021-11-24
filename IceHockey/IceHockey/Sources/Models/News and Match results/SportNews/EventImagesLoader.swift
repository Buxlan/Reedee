//
//  EventImagesLoader.swift
//  IceHockey
//
//  Created by  Buxlan on 11/17/21.
//

class EventImagesLoader: FirebaseImagesLoaderImpl {
    
    init(objectIdentifier: String,
         imagesIdentifiers: [String]) {
        let imagesPath = "events/\(objectIdentifier)"
        super.init(objectIdentifier: objectIdentifier,
                   imagesIdentifiers: imagesIdentifiers,
                   imagesPath: imagesPath)
    }
    
}
