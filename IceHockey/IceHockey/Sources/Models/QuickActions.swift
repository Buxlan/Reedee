//
//  QuickActions.swift
//  IceHockey
//
//  Created by  Buxlan on 9/21/21.
//
import UIKit

enum QuickAction: Int, RawRepresentable, Codable, CustomStringConvertible {
    case joinClub
    case showTrainingSchedule
    case photoGallery
    case contacts
    case showOnMap
    case action3
    
    var description: String {
        switch self {
        case .joinClub:
            return L10n.Actions.signUpToClub
        case .showTrainingSchedule:
            return L10n.Actions.showTrainingSchedule
        case .photoGallery:
            return L10n.Actions.photoGallery
        case .contacts:
            return L10n.Actions.contacts
        case .showOnMap:
            return L10n.Actions.action2
        case .action3:
            return L10n.Actions.action3
        }
    }
    
    var image: UIImage {
        var image: UIImage
        switch self {
        case .showTrainingSchedule:
            image = Asset.timetable.image
        case .joinClub:
            image = Asset.crowd.image
        case .photoGallery:
            image = Asset.photo.image
        case .contacts:
            image = Asset.contacts.image
        case .showOnMap:
            image = Asset.questionMark.image
        case .action3:
            image = Asset.questionMark.image
        }
        return image
    }
}
