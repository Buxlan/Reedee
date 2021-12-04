//
//  SaveCellModel.swift
//  IceHockey
//
//  Created by  Buxlan on 11/13/21.
//

import Foundation
import UIKit

struct SaveCellModel: TableCellModel {
    
    // MARK: - Properties
    var title: String
    var textColor: UIColor = Asset.other3.color
    var backgroundColor: UIColor = Asset.other1.color
    var buttonBackgroundColor: UIColor = Asset.accent0.color
    var font: UIFont = Fonts.Medium.title
    
    // MARK: - Actions
    
    var action = {}
    
    // MARK: - Lifecircle
    
    init(title: String = L10n.Other.save) {
        self.title = title
    }
    
}
