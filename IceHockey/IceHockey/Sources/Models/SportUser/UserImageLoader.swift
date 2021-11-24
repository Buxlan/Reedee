//
//  UserImageLoader.swift
//  IceHockey
//
//  Created by  Buxlan on 11/24/21.
//

import Firebase

class UserImageLoader: FirebaseImagesLoaderImpl {
    
    init(objectIdentifier: String,
         imageIdentifier: String) {
        let imagesPath = "users/\(objectIdentifier)"
        let imagesIdentifiers = [imageIdentifier]
        super.init(objectIdentifier: objectIdentifier,
                   imagesIdentifiers: imagesIdentifiers,
                   imagesPath: imagesPath)
    }
    
}

