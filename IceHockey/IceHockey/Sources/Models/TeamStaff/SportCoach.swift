//
//  Coach.swift
//  IceHockey
//
//  Created by  Buxlan on 9/6/21.
//

import UIKit

struct SportCoach: Codable {
    var displayName: String
    var description: String
    var imageURL: URL?
    var id: String
    
    init(id: String,
         displayName: String,
         description: String,
         imageURL: URL? = nil) {
        self.id = id
        self.displayName = displayName
        self.imageURL = imageURL
        self.description = description
    }
}
