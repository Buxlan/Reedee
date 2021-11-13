//
//  DateCellModel.swift
//  IceHockey
//
//  Created by  Buxlan on 11/13/21.
//

import Foundation
import UIKit

struct DateCellModel: TableCellModel {
    
    // MARK: - Properties
    var date: Date
    var textColor: UIColor = Asset.textColor.color
    var backgroundColor: UIColor = Asset.other3.color
    var font: UIFont = .regularFont16
    
    // MARK: - Actions
    
    // MARK: - Lifecircle
    
    init(_ date: Date? = nil) {
        self.date = date ?? Date()
    }
    
}
