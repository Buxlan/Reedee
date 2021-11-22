//
//  TeamStorageFlowData.swift
//  IceHockey
//
//  Created by  Buxlan on 11/22/21.
//

import UIKit

protocol TeamStorageFlowData {
    var objectIdentifier: String { get set }
    var images: [ImageData] { get set }
}

struct DefaultTeamStorageFlowData: TeamStorageFlowData {
    var objectIdentifier: String = ""
    var images: [ImageData] = []
}

class TeamStorageFlowDataImpl: TeamStorageFlowData {
    
    // MARK: - Properties
    
    var objectIdentifier: String
    var images: [ImageData]
    
    private var handlers: [String: (UIImage?) -> Void] = [:]
    
    // MARK: - Lifecircle
    
    init() {
        images = []
        objectIdentifier = ""
    }
    
    init(objectIdentifier: String,
         images: [ImageData]) {
        self.images = images
        self.objectIdentifier = objectIdentifier
    }
    
    // MARK: - Helper methods
    
}
