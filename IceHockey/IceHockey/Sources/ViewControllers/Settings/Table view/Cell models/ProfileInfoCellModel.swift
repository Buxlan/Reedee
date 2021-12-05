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
    
    init(username: String,
         image: UIImage?) {
        self.username = username
        self.image = image
        self.userIdentifier = FirebaseAuthManager.shared.current?.uid ?? "uid: <unfilled>"
    }
    
    init (user: ApplicationUser) {
        self.username = user.displayName
        self.userIdentifier = user.uid
        self.image = user.sportUser.image
        self.userIdentifier = "uid: " + user.uid
    }
    
}
