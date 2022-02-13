//
//  InputPasswordCellModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 13.02.2022.
//

import UIKit

struct InputPasswordCellModel {
    
    var value: String
    
    var backgroundColor: UIColor = .white
    var textColor: UIColor = Asset.textColor.color
    var tintColor: UIColor = Asset.other1.color
    var font: UIFont = Fonts.Regular.body
    
    var action = {}
    
    init(value: String) {
        self.value = value
    }
    
}
