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
    var textColor: UIColor = Asset.textColor.color
    var backgroundColor: UIColor = Asset.other3.color
    var font: UIFont = .regularFont17
    
    // MARK: - Actions
    
    var action = {}
    
    // MARK: - Lifecircle
    
    init(_ title: String = L10n.Other.save) {
        self.title = title
    }
    
}
