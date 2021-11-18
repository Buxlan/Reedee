//
//  EventDetailUserCellModel.swift
//  IceHockey
//
//  Created by  Buxlan on 11/12/21.
//

import UIKit

struct EventDetailUserCellModel: TableCellModel {
    
    // MARK: - Properties
    var author: String
    var image: UIImage?
    var type: SportEventType
    var textColor: UIColor = Asset.textColor.color
    var backgroundColor: UIColor = Asset.other3.color
    var font: UIFont = .regularFont16
    
    // MARK: - Actions
    
    // MARK: - Lifecircle
    
    init(_ event: SportEvent) {
        author = event.author?.displayName ?? ""
        image = event.author?.image
        type = event.type
    }
    
}
