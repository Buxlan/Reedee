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
    var placeholderColor: UIColor = Asset.other1.color
    var textColor: UIColor = Asset.textColor.color
    var backgroundColor: UIColor = Asset.other1.color
    var font: UIFont = .bxBody1
    var textFieldBackgroundColor: UIColor = Asset.other3.color
    
    // MARK: - Actions
    
    var valueChanged: (Date) -> Void = { _ in }
    
    // MARK: - Lifecircle
    
    init(_ date: Date? = nil) {
        self.date = date ?? Date()
    }
    
}
