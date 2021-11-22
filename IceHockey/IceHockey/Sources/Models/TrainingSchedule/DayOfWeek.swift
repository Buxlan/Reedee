//
//  DayOfWeek.swift
//  IceHockey
//
//  Created by  Buxlan on 11/21/21.
//

enum DayOfWeek: String, CustomStringConvertible, Codable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case unknown
    
    var description: String {
        switch self {
        case .sunday:
            return L10n.Day.sunday
        case .monday:
            return L10n.Day.monday
        case .tuesday:
            return L10n.Day.tuesday
        case .wednesday:
            return L10n.Day.wednesday
        case .thursday:
            return L10n.Day.thursday
        case .friday:
            return L10n.Day.friday
        case .saturday:
            return L10n.Day.saturday
        case .unknown:
            return L10n.Day.unknown
        }
    }
    
    init(rawValue: String) {
        switch rawValue {
        case "sunday":
            self = .sunday
        case "monday":
            self = .monday
        case "tuesday":
            self = .tuesday
        case "wednesday":
            self = .wednesday
        case "thursday":
            self = .thursday
        case "friday":
            self = .friday
        case "saturday":
            self = .saturday
        default:
            self = .unknown
        }
    }
}
