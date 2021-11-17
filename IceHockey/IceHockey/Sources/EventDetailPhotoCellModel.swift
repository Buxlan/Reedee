//
//  ImageDataConfiguration.swift
//  IceHockey
//
//  Created by  Buxlan on 10/27/21.
//

import UIKit

struct EventDetailPhotoCellModel: TableCellModel {
    
    let image: UIImage?
    
    init(image: UIImage?) {
        self.image = image
    }
    
}
