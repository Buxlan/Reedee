//
//  MatchResultEditCellModel.swift
//  IceHockey
//
//  Created by  Buxlan on 11/7/21.
//

import UIKit

struct MatchResultEditCellModel: TableCellModel {
    
    // MARK: - Properties
    
    var objectIdentifier: String
    var title: String
    var homeTeam: String
    var awayTeam: String
    var matchName: String
    
    var homeTeamScore: Int = 0
    var awayTeamScore: Int = 0
    
    var stadium: String
    var date: String
    var status: String
    
    var backgroundColor: UIColor = Asset.other3.color
    var textColor: UIColor = Asset.textColor.color
    var font: UIFont = Fonts.Regular.subhead
    
    var type: SportEventType
    
    var likesCount: Int = 0
    
    // MARK: - Actions
    
    var setTitleAction: (String) -> Void = { _ in }
    var setHomeTeamAction: (String) -> Void = { _ in }
    var setAwayTeamAction: (String) -> Void = { _ in }
    var setHomeTeamScoreAction: (Int) -> Void = { _ in }
    var setAwayTeamScoreAction: (Int) -> Void = { _ in }
    var setStadiumAction: (String) -> Void = { _ in }
    var setDateAction: (Date) -> Void = { _ in }    
    
    // MARK: - Lifecircle
    
    init(data: MatchResult) {
        homeTeam = data.homeTeam
        awayTeam = data.awayTeam
        stadium = data.stadium
        status = data.status.description
        
        homeTeamScore = data.homeTeamScore
        awayTeamScore = data.awayTeamScore
        
        matchName = "\(data.homeTeam) vs \(data.awayTeam)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        date = dateFormatter.string(from: data.date)
        
        type = data.type
        title = data.title
        objectIdentifier = data.objectIdentifier
        
    }
}
