//
//  NewsTableCellModel.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 11/4/21.
//

import UIKit

struct NewsTableCellModel: TableCellModel {
    
    var objectIdentifier: String
    var title: String
    var description: String
    var image: UIImage?
    var type: String
    
    var author: String?
    var authorImage: UIImage?
    
    var date: String
    
    var backgroundColor: UIColor = Asset.other3.color
    var textColor: UIColor = Asset.textColor.color
    var font: UIFont = Fonts.Regular.body
    
    var typeBackgroundColor: UIColor
    var typeTextColor: UIColor
    var likesInfo: EventLikesInfo
    var viewsInfo: EventViewsInfo
    
    var likeAction: (Bool) -> Void = { _ in }
    var shareAction = {}
    
    init(data: SportNews) {
        objectIdentifier = data.objectIdentifier
        title = data.title
        description = data.text
        image = data.mainImage
        type = data.type.description
        author = data.author?.displayName
        authorImage = data.author?.image
        image = data.mainImage
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let dateString = dateFormatter.string(from: data.date)
        date = dateString
        
        typeBackgroundColor = data.type.backgroundColor
        typeTextColor = data.type.textColor
        likesInfo = data.likesInfo
        viewsInfo = data.viewsInfo
    }
}
