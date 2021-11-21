//
//  MatchResultStatus.swift.swift
//  IceHockey
//
//  Created by  Buxlan on 11/21/21.
//

enum MatchStatus: Int, CustomStringConvertible {
    case planned
    case inProgress
    case finished
    
    var description: String {
        switch self {
        case .planned:
            return L10n.MatchStatus.plannedTitle
        case .inProgress:
            return L10n.MatchStatus.inProgressTitle
        case .finished:
            return L10n.MatchStatus.finishedTitle
        }
    }
}
