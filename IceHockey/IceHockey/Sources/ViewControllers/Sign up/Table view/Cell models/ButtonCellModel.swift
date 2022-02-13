//
//  ButtonCellModel.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 13.02.2022.
//

import UIKit

struct ButtonCellModel: TableCellModel, TintColorable {
    
    var text: String
    
    var backgroundColor: UIColor = Colors.Accent.blue
    var contentViewBackgroundColor: UIColor = Colors.Gray.ultraLight
    var textColor: UIColor = Colors.Gray.ultraLight
    var tintColor: UIColor = Colors.Gray.ultraLight
    var font: UIFont = Fonts.Regular.body
    
    var action = {}
    
    init(text: String) {
        self.text = text
    }
    
}
