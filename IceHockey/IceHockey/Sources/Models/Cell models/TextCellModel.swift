//
//  EventDetailTitleCellModel.swift
//  IceHockey
//
//  Created by  Buxlan on 11/12/21.
//

import UIKit

struct TextCellModel: TableCellModel {
    
    // MARK: - Properties
    var text: String
    var placeholderColor: UIColor = Asset.other1.color
    var textColor: UIColor = Asset.textColor.color
    var backgroundColor: UIColor = Asset.other1.color    
    var font: UIFont = .bxBody1
    var lightBackgroundColor: UIColor = Asset.other3.color
        
    // MARK: - Actions
    
    var valueChanged: (String) -> Void = { _ in }
    
    // MARK: - Lifecircle
    
}
