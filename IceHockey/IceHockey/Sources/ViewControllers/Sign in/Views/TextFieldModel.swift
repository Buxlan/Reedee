//
//  TextFieldModel.swift
//  IceHockey
//
//  Created by  Buxlan on 12/6/21.
//

import UIKit

struct TextFieldModel: TableCellModel, TintColorable {
    
    var textColor: UIColor = Asset.textColor.color
    var backgroundColor: UIColor = Colors.Gray.light
    var tintColor: UIColor = Colors.Gray.dark
    var font: UIFont = Fonts.Regular.subhead
    
    var placeholderText: String
    
}
