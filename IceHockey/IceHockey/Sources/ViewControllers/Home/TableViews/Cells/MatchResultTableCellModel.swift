//
//  MatchResultTableCellModel.swift
//  IceHockey
//
//  Created by  Buxlan on 11/3/21.
//

import Foundation

protocol TableCellModel {
    
}

struct MatchResultTableCellModel: TableCellModel {
    
    var eventUid: String
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
    
    var type: String
    
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
        eventUid = data.uid
    }
}
