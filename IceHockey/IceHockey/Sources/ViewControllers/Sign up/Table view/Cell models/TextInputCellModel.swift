//
//  InputDisplayNameCellModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 13.02.2022.
//

import UIKit

struct TextInputCellModel: TableCellModel, TintColorable {
    
    var value: String
    var placeholderText: String
    
    var backgroundColor: UIColor = Colors.Gray.light
    var contentViewBackgroundColor: UIColor = .white
    var textColor: UIColor = Asset.textColor.color
    var tintColor: UIColor = Colors.Gray.dark
    var font: UIFont = Fonts.Regular.body
    
    var action = {}
    
    init(value: String, placeholderText: String = "") {
        self.value = value
        self.placeholderText = placeholderText
    }
    
}
