//
//  TrainingType.swift
//  IceHockey
//
//  Created by  Buxlan on 11/21/21.
//

enum TrainingType: String, Codable, CustomStringConvertible {
    case ice
    case gym
    case unknown
    
    var description: String {
        switch self {
        case .ice:
            return L10n.TrainingType.ice
        case .gym:
            return L10n.TrainingType.gym
        case .unknown:
            return L10n.TrainingType.unknown
        }
    }
    
    init(rawValue: String) {
        switch rawValue {
        case "ice":
            self = .ice
        case "gym":
            self = .gym
        default:
            self = .unknown
        }
    }
}
