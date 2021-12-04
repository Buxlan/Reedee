//
//  TeamInfoCellModel.swift
//  IceHockey
//
//  Created by  Buxlan on 12/4/21.
//

import UIKit

struct ClubInfoCellModel: TableCellModel, TintColorable {
    
    // MARK: - Properties
    var phone: String
    var address: String
    var email: String
    
    var textColor: UIColor = Asset.textColor.color
    var backgroundColor: UIColor = Asset.other3.color
    var font: UIFont = Fonts.Regular.subhead
    var tintColor: UIColor = .black
        
    // MARK: - Actions
    
    // MARK: - Lifecircle
    
    init(data: Club) {
        phone = data.phone
        address = data.address
        email = data.email
    }
    
}
