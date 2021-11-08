//
//  MatchResultTableCellModel.swift
//  IceHockey
//
//  Created by  Buxlan on 11/3/21.
//

import UIKit

protocol TableCellModel {
}

struct MatchResultTableCellModel: TableCellModel {
    
    var uid: String
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
    
    var type: String
    var likesCount: Int = 0
    
    var likeAction: (Bool) -> Void = { _ in }
    var shareAction = {}
    
    init(data: MatchResult) {
        homeTeam = data.homeTeam
        awayTeam = data.awayTeam
        stadium = data.stadium
        status = data.status
        
        homeTeamScore = data.homeTeamScore
        awayTeamScore = data.awayTeamScore
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        date = dateFormatter.string(from: data.date)
        
        type = data.type.description
        title = data.title
        uid = data.uid
        
        typeBackgroundColor = data.type.backgroundColor
        typeTextColor = data.type.textColor
    }
}
