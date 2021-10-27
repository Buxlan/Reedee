//
//  ImageDataConfiguration.swift
//  IceHockey
//
//  Created by  Buxlan on 10/27/21.
//

import Foundation

struct ImageDataConfiguration {
    let name: String
    let id: String
    let eventUID: String
    init(name: String, imageID: String, eventUID: String) {
        self.name = name
        self.eventUID = eventUID
        self.id = imageID
    }
}
