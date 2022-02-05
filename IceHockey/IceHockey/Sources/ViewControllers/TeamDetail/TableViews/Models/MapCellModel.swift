//
//  MapCellModel.swift
//  IceHockey
//
//  Created by  Buxlan on 12/4/21.
//

import UIKit

struct MapCellModel: TableCellModel {
    
    // MARK: - Properties
    var displayName: String
    var location: Coord?
    
    var textColor: UIColor = Asset.textColor.color
    var backgroundColor: UIColor = Asset.other3.color
    var font: UIFont = Fonts.Regular.subhead
        
    // MARK: - Actions
    
    // MARK: - Lifecircle
    
    init(data: Club?) {
        displayName = data?.displayName ?? ""
        location = data?.location
    }
    
}
