//
//  Coach.swift
//  IceHockey
//
//  Created by  Buxlan on 9/6/21.
//

import UIKit

protocol Staff {
    var displayName: String { get set }
}

struct Coach: Staff, Codable, Identifiable {
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

extension Coach {
    var image: UIImage {
        let emptyImage = Asset.person.image
        guard let url = imageURL else {
            return emptyImage
        }
        guard let data = try? Data(contentsOf: url) else {
            return emptyImage
        }
        let image = UIImage(data: data)
        return image ?? emptyImage
    }
}
