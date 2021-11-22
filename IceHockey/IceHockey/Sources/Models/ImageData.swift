//
//  ImageData.swift
//  IceHockey
//
//  Created by  Buxlan on 11/22/21.
//

import UIKit

struct ImageData: Hashable {
    var imageID: String = ""
    var image: UIImage?
    var isNew: Bool = false
    var isRemoved: Bool = false
}
