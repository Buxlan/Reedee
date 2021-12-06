//
//  ProfileInfoCellModel.swift
//  IceHockey
//
//  Created by  Buxlan on 12/5/21.
//

import UIKit

struct ProfileInfoCellModel: TableCellModel, TintColorable {
    
    var username: String
    var image: UIImage?
    var userIdentifier: String = ""
    
    var backgroundColor: UIColor = Asset.other2.color
    var textColor: UIColor = Asset.textColor.color
    var tintColor: UIColor = Asset.other0.color
    var font: UIFont = Fonts.Medium.title
    var userIdentifierFont = Fonts.Regular.caption
    
    var action = {}
    
    init() {
        self.username = "<unknown>"
        self.image = nil
        self.userIdentifier = "uid: <unknown>"
    }
    
    init (user: ApplicationUser) {
        self.username = user.displayName
        self.userIdentifier = user.uid
        self.image = user.sportUser.image
        let lastSymbols = user.uid.suffix(14)
        self.userIdentifier = "uid: \(lastSymbols)"
    }
    
}
