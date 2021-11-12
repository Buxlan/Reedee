//
//  ImageDataConfiguration.swift
//  IceHockey
//
//  Created by  Buxlan on 10/27/21.
//

import Foundation

struct EventDetailPhotoCellModel: TableCellModel {
    
    let imageID: String
    let eventID: String
    
    init(imageID: String, eventUID: String) {        
        self.eventID = eventUID
        self.imageID = imageID
    }
    
}
