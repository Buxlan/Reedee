//
//  SportEventType.swift
//  IceHockey
//
//  Created by  Buxlan on 10/14/21.
//

import UIKit

enum SportEventType: Int, Codable {
    case event
    case match
//    case ad
//    case other
//    case photo
//    case comingSoon
}

extension SportEventType {
    var description: String {
        switch self {
        case .match:
            return L10n.Events.typeMatch
        case .event:
            return L10n.Events.typeEvent
//        case .ad:
//            return L10n.Events.typeAd
//        case .other:
//            return L10n.Events.typeOther
//        case .photo:
//            return L10n.Events.typePhoto
//        case .comingSoon:
//            return L10n.Events.typeComingSoon
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .match:
            return Asset.accent0.color
        case .event:
            return Asset.accent2.color
//        case .ad:
//            return Asset.accent1.color
//        case .other:
//            return Asset.accent3.color
//        case .photo:
//            return Asset.accent0.color
//        case .comingSoon:
//            return Asset.accent1.color
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .match:
            return Asset.other2.color
        case .event:
            return Asset.other2.color
//        case .ad:
//            return Asset.other2.color        
//        case .other:
//            return Asset.other2.color
//        case .photo:
//            return Asset.other2.color
//        case .comingSoon:
//            return Asset.other2.color
        }
    }
}
