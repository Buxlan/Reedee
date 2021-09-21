//
//  QuickActions.swift
//  IceHockey
//
//  Created by  Buxlan on 9/21/21.
//
import UIKit

enum QuickActionType: String, Codable {
    case joinClub
    case showTrainingSchedule
    case photoGallery
    case contacts
    case action2
    case action3
    
    func description() -> String {
        switch self {
        case .joinClub:
            return L10n.Actions.signUpToClub
        case .showTrainingSchedule:
            return L10n.Actions.showTrainingSchedule
        case .photoGallery:
            return L10n.Actions.photoGallery
        case .contacts:
            return L10n.Actions.contacts
        case .action2:
            return L10n.Actions.action2
        case .action3:
            return L10n.Actions.action3
        }
    }
}

struct QuickAction: Codable {
    let type: QuickActionType
    var imageURL: URL?
    var imageName: String?
}

extension QuickAction {
    var title: String {
        type.description()
    }
    var imageSize: CGSize {
        CGSize(width: 40, height: 40)
    }
    
    var image: UIImage? {
        var image: UIImage?
        if let imageName = imageName {
            image = UIImage(named: imageName)
        } else if let url = imageURL,
                  let data = try? Data(contentsOf: url) {
            image = UIImage(data: data)
        }
        image = image ?? defaultImage
        return image
    }
    
    private var defaultImage: UIImage {
        var image: UIImage
        switch type {
        case .showTrainingSchedule:
            image = Asset.timetable.image
        case .joinClub:
            image = Asset.crowd.image
        case .photoGallery:
            image = Asset.photo.image
        case .contacts:
            image = Asset.contacts.image
        case .action2:
            image = Asset.questionMark.image
        case .action3:
            image = Asset.questionMark.image
        }
        return image
    }
}
