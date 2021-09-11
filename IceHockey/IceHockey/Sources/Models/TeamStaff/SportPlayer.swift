//
//  HockeyPlayer.swift
//  IceHockey
//
//  Created by  Buxlan on 9/6/21.
//
import UIKit

enum HockeyPlayerRole: String, Codable {
    case striker
    case defender
    case goalkeeper
    
    var description: String {
        var description: String
        switch self {
        case .striker:
            description = L10n.HockeyPlayer.positionStrikerPlural
        case .defender:
            description = L10n.HockeyPlayer.positionDefenderPlural
        case .goalkeeper:
            description = L10n.HockeyPlayer.positionGoalkeeperPlural
        }
        return description
    }
}

struct SportPlayer: Staff, Codable, Identifiable {
    var displayName: String
    var imageURL: URL?
    var position: HockeyPlayerRole
    var gameNumber: Int
    var id: String
    
    init(id: String,
         displayName: String,
         position: HockeyPlayerRole,
         gameNumber: Int,
         imageURL: URL? = nil) {
        self.id = id
        self.displayName = displayName
        self.imageURL = imageURL
        self.position = position
        self.gameNumber = gameNumber
    }
}

extension SportPlayer {
    var image: UIImage {
        let emptyImage = Asset.player0.image
        guard let url = imageURL else {
            return emptyImage
        }
        guard let data = try? Data(contentsOf: url) else {
            return emptyImage
        }
        let image = UIImage(data: data)
        return image ?? emptyImage
    }
}
