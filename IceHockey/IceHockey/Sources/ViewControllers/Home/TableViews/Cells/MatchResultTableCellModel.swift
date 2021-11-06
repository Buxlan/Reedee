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
    var score: String
    var matchName: String
    
    var stadium: String
    var date: String
    var status: String
    
    var homeTeamLogoName: String? = "small"
    var awayTeamLogoName: String? = "small"
    
    var backgroundColor: UIColor = Asset.other3.color
    var textColor: UIColor = Asset.textColor.color
    
    var typeBackgroundColor: UIColor
    var typeTextColor: UIColor
    
    var type: String
    
    var likeAction: (Bool) -> Void = { _ in }
    var shareAction = {}
    
    init(data: SportEvent) {
        guard let data = data as? MatchResult else { fatalError() }
        homeTeam = data.homeTeam
        awayTeam = data.awayTeam
        stadium = data.stadium
        status = data.status
        
        score = "\(data.homeTeamScore) : \(data.awayTeamScore)"
        matchName = "\(data.homeTeam) vs \(data.awayTeam)"
        
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
