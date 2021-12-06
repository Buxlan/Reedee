//
//  SquadCellModel.swift
//  IceHockey
//
//  Created by  Buxlan on 12/4/21.
//

import UIKit

struct SquadCellModel: TableCellModel {
    
    // MARK: - Properties
    var displayName: String
    
    var textColor: UIColor = Asset.textColor.color
    var backgroundColor: UIColor = Asset.other3.color
    var font: UIFont = Fonts.Regular.subhead
        
    // MARK: - Actions
    
    // MARK: - Lifecircle
    
    init(data: Squad) {
        displayName = data.displayName
    }
    
}
