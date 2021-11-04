//
//  NewsTableCellModel.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 11/4/21.
//

import UIKit

struct NewsTableCellModel: TableCellModel {
    
    var uid: String
    var title: String
    var description: String
    var imageID: String
    var type: String
    
    var date: String
    
    var typeBackgroundColor: UIColor
    var typeTextColor: UIColor
    
    init(data: SportNews) {
        uid = data.uid
        title = data.title
        description = data.text
        imageID = data.mainImageID ?? ""
        type = data.type.description
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let dateString = dateFormatter.string(from: data.date)
        date = dateString
        
        typeBackgroundColor = data.type.backgroundColor
        typeTextColor = data.type.textColor
    }
}
