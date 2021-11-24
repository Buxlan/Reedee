//
//  ClubStorageFlowData.swift
//  IceHockey
//
//  Created by  Buxlan on 11/22/21.
//

import UIKit

protocol ClubStorageFlowData {
    var objectIdentifier: String { get set }
    var images: [ImageData] { get set }
}

struct EmptyClubStorageFlowData: ClubStorageFlowData {
    var objectIdentifier: String = ""
    var images: [ImageData] = []
}

class ClubStorageFlowDataImpl: ClubStorageFlowData {
    
    // MARK: - Properties
    
    var objectIdentifier: String
    var images: [ImageData]
    
    private var handlers: [String: (UIImage?) -> Void] = [:]
    
    // MARK: - Lifecircle
    
    init(objectIdentifier: String = "",
         images: [ImageData] = []) {
        self.images = images
        self.objectIdentifier = objectIdentifier
    }
    
    // MARK: - Helper methods
    
}
