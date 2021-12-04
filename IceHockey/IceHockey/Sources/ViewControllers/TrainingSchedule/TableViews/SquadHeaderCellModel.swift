//
//  SquadHeaderCellModel.swift
//  IceHockey
//
//  Created by  Buxlan on 11/10/21.
//

import UIKit

struct SquadHeaderCellModel: TableCellModel {
    
    var textColor: UIColor = Asset.textColor.color
    var backgroundColor: UIColor = Asset.other3.color
    var font: UIFont = Fonts.Regular.subhead    
    
    // MARK: - Properties
    var uid: String
    var title: String
        
    // MARK: - Actions
    
    // MARK: - Lifecircle
    
}
