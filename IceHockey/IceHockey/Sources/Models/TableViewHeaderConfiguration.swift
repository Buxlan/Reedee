//
//  TableViewHeader.swift
//  IceHockey
//
//  Created by  Buxlan on 9/12/21.
//

import UIKit

enum TableViewHeaderType: Int, Codable {
    case news
    case pinnedEvents
    case comingEvents
    case photoGallery
    case videoGallery
    case partners
}

struct TableViewHeaderConfiguration: Codable, Sizeable {
    var type: TableViewHeaderType
    var leftImageName: String?
    var rightImageName: String?
    var title: String?
    var backgroundColor: CodableColor
    var tintColor: CodableColor
    var textColor: CodableColor
    var size: CGSize
        
    private var leftImageSize: CGSize
    private var rightImageSize: CGSize
    static let defaultImageSize = CGSize(width: 40, height: 24)
    
    init(type: TableViewHeaderType, size: CGSize) {
        self.type = type
        self.size = size
        leftImageSize = Self.defaultImageSize
        rightImageSize = Self.defaultImageSize
        
        backgroundColor = Asset.other2.color.codableColor
        tintColor = Asset.textColor.color.codableColor
        textColor = Asset.textColor.color.codableColor
        
        configure()
    }
    
    private mutating func configure() {
        switch type {
        case .pinnedEvents:
            backgroundColor = Asset.other2.color.codableColor
            tintColor = Asset.textColor.color.codableColor
            textColor = Asset.textColor.color.codableColor
        case .news:
            leftImageName = "home"
            rightImageName = "chevronRight"
            leftImageSize = CGSize(width: 0, height: 18)
            rightImageSize = CGSize(width: 0, height: 18)
            title = L10n.News.tableViewNewsSectionTitle
            backgroundColor = Asset.other2.color.codableColor
            tintColor = Asset.textColor.color.codableColor
            textColor = Asset.textColor.color.codableColor
        default:
            leftImageName = "questionMark"
            rightImageName = "chevronRight"
            leftImageSize = CGSize(width: 0, height: 18)
            rightImageSize = CGSize(width: 0, height: 18)
            title = L10n.News.tableViewNewsSectionTitle
            backgroundColor = Asset.other2.color.codableColor
            tintColor = Asset.textColor.color.codableColor
            textColor = Asset.textColor.color.codableColor            
        }
        
    }
}

extension TableViewHeaderConfiguration {
    var leftImage: UIImage? {
        var image: UIImage?
        if let imageName = leftImageName {
            image = UIImage(named: imageName)?
                .resizeImage(to: leftImageSize.height, aspectRatio: .current, with: .clear)
                .withRenderingMode(.alwaysTemplate)
        }
        return image
    }
    var rightImage: UIImage? {
        var image: UIImage?
        if let imageName = rightImageName {
            image = UIImage(named: imageName)?
                .resizeImage(to: leftImageSize.height, aspectRatio: .current, with: .clear)
                .withRenderingMode(.alwaysTemplate)
        }
        return image
    }
}
