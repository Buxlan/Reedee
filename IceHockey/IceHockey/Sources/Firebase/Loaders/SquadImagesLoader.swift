//
//  SquadImagesLoader.swift
//  IceHockey
//
//  Created by  Buxlan on 11/22/21.
//

import Firebase

class SquadImagesLoader: FirebaseImagesLoaderImpl {
    
    init(objectIdentifier: String,
         imagesIdentifiers: [String]) {
        let imagesPath = "squads/\(objectIdentifier)"
        super.init(objectIdentifier: objectIdentifier,
                   imagesIdentifiers: imagesIdentifiers,
                   imagesPath: imagesPath)
    }
    
}
