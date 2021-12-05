//
//  SettingCellModel.swift
//  IceHockey
//
//  Created by  Buxlan on 11/5/21.
//

import UIKit

struct SettingCellModel: TableCellModel, TintColorable {
    
    var title: String
    var hasDisclosure: Bool
    
    var backgroundColor: UIColor = .white
    var textColor: UIColor = Asset.textColor.color
    var tintColor: UIColor = Asset.other1.color
    var font: UIFont = Fonts.Regular.body
    
    var action = {}
    
    init(title: String,
         hasDisclosure: Bool = false) {
        self.title = title
        self.hasDisclosure = hasDisclosure
    }
    
}
