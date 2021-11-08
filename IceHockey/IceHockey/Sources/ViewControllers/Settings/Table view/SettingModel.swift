//
//  SettingModel.swift
//  IceHockey
//
//  Created by  Buxlan on 11/5/21.
//

import UIKit

struct SettingCellModel {
    
    var title: String
    var hasDisclosure: Bool
    
    var backgroundColor: UIColor
    var textColor: UIColor
    
    var action = {}
    
    init(title: String,
         hasDisclosure: Bool,
         backgroundColor: UIColor = Asset.other2.color,
         textColor: UIColor = Asset.textColor.color) {
        self.title = title
        self.hasDisclosure = hasDisclosure
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
    
}
