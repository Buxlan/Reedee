//
//  MatchResultTableCellModel.swift
//  IceHockey
//
//  Created by  Buxlan on 11/3/21.
//

import UIKit

struct MatchResultTableCellModel: TableCellModel {
    
    var font: UIFont = .regularFont15
    
    var objectIdentifier: String
        
    var author: String?
    var authorImage: UIImage?
    
    var title: String
    var homeTeam: String
    var awayTeam: String
    
    var homeTeamScore: Int = 0
    var awayTeamScore: Int = 0
    
    var stadium: String
    var date: String
    var status: String
    
    var backgroundColor: UIColor = Asset.other3.color
    var textColor: UIColor = Asset.textColor.color
    
    var typeBackgroundColor: UIColor
    var typeTextColor: UIColor
    
    var likesInfo: EventLikesInfo
    var viewsInfo: EventViewsInfo
    
    var type: String
    
    var likeAction: (Bool) -> Void = { _ in }
    var shareAction = {}
    
    init(data: MatchResult) {
        homeTeam = data.homeTeam
        awayTeam = data.awayTeam
        stadium = data.stadium
        status = data.status.description
        author = data.author?.displayName
        authorImage = data.author?.image
        
        homeTeamScore = data.homeTeamScore
        awayTeamScore = data.awayTeamScore
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        date = dateFormatter.string(from: data.date)
        
        type = data.type.description
        title = data.title
        objectIdentifier = data.objectIdentifier
        
        typeBackgroundColor = data.type.backgroundColor
        typeTextColor = data.type.textColor
        likesInfo = data.likesInfo
        viewsInfo = data.viewsInfo
    }
}
