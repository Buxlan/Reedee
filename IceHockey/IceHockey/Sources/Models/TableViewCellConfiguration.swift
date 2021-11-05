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

protocol SimpleTableHeaderConfiguration {
    var title: String? { get set }
}

struct TitleTableHeaderData: SimpleTableHeaderConfiguration {
    var title: String?
}

protocol TableViewCellHeaderConfiguration: SimpleTableHeaderConfiguration, Codable {
    var leftImageName: String? { get set }
    var rightImageName: String? { get set }
    var title: String? { get set }
    var backgroundColor: CodableColor { get set }
    var tintColor: CodableColor { get set }
    var textColor: CodableColor { get set }
    var size: CGSize { get set }
    
    var leftImageSize: CGSize { get set }
    var rightImageSize: CGSize { get set }
    
    init(size: CGSize?,
         leftImageSize: CGSize?,
         rightImageSize: CGSize?)
}

extension TableViewCellHeaderConfiguration {
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

struct PinnedEventTableCellHeaderConfiguration: TableViewCellHeaderConfiguration {
    var leftImageName: String?
    var rightImageName: String?
    var title: String?
    var backgroundColor: CodableColor
    var tintColor: CodableColor
    var textColor: CodableColor
    var size: CGSize
    
    var leftImageSize: CGSize
    var rightImageSize: CGSize
    
    init(size: CGSize? = nil,
         leftImageSize: CGSize? = nil,
         rightImageSize: CGSize? = nil) {
        // Colors
        self.backgroundColor = Asset.other2.color.codableColor
        self.tintColor = Asset.textColor.color.codableColor
        self.textColor = Asset.textColor.color.codableColor
        // Size
        let defaultSize = CGSize(width: 0, height: 44)
        let defaultImageSize = CGSize(width: 40, height: 24)
        self.size = size ?? defaultSize
        self.leftImageSize = leftImageSize ?? defaultImageSize
        self.rightImageSize = rightImageSize ?? defaultImageSize
    }
}

struct PhotoEventTableCellHeaderConfiguration: TableViewCellHeaderConfiguration {
    var leftImageName: String?
    var rightImageName: String?
    var title: String?
    var backgroundColor: CodableColor
    var tintColor: CodableColor
    var textColor: CodableColor
    var size: CGSize
    
    var leftImageSize: CGSize
    var rightImageSize: CGSize
    
    init(size: CGSize? = nil,
         leftImageSize: CGSize? = nil,
         rightImageSize: CGSize? = nil) {
        // Colors
        self.backgroundColor = Asset.other2.color.codableColor
        self.tintColor = Asset.textColor.color.codableColor
        self.textColor = Asset.textColor.color.codableColor
        // Size
        let defaultSize = CGSize(width: 0, height: 44)
        let defaultImageSize = CGSize(width: 40, height: 24)
        self.size = size ?? defaultSize
        self.leftImageSize = leftImageSize ?? defaultImageSize
        self.rightImageSize = rightImageSize ?? defaultImageSize
    }
}

struct NewsTableViewCellHeaderConfiguration: TableViewCellHeaderConfiguration {
    var leftImageName: String?
    var rightImageName: String?
    var title: String?
    var backgroundColor: CodableColor
    var tintColor: CodableColor
    var textColor: CodableColor
    var size: CGSize
    
    static let defaultSize = CGSize(width: 0, height: 44)
    static let defaultImageSize = CGSize(width: 40, height: 24)
    
    var leftImageSize: CGSize
    var rightImageSize: CGSize
    
    init(size: CGSize? = nil,
         leftImageSize: CGSize? = nil,
         rightImageSize: CGSize? = nil) {
        
        // Colors
        self.backgroundColor = Asset.other2.color.codableColor
        self.tintColor = Asset.textColor.color.codableColor
        self.textColor = Asset.textColor.color.codableColor
        // Size
        self.size = size ?? Self.defaultSize
        self.leftImageSize = leftImageSize ?? Self.defaultImageSize
        self.rightImageSize = rightImageSize ?? Self.defaultImageSize
        // Data
        self.leftImageName = "home"
        self.rightImageName = "chevronRight"
        self.title = L10n.News.tableViewNewsSectionTitle
    }
}

struct ComingEventsTableCellHeaderConfiguration: TableViewCellHeaderConfiguration {
    var leftImageName: String?
    var rightImageName: String?
    var title: String?
    var backgroundColor: CodableColor
    var tintColor: CodableColor
    var textColor: CodableColor
    var size: CGSize
    
    var leftImageSize: CGSize
    var rightImageSize: CGSize
    
    static let defaultSize = CGSize(width: 0, height: 44)
    static let defaultImageSize = CGSize(width: 40, height: 24)
    
    init(size: CGSize? = nil,
         leftImageSize: CGSize? = nil,
         rightImageSize: CGSize? = nil) {
        // Colors
        self.backgroundColor = Asset.other2.color.codableColor
        self.tintColor = Asset.textColor.color.codableColor
        self.textColor = Asset.textColor.color.codableColor
        // Size
        self.size = size ?? Self.defaultSize
        self.leftImageSize = leftImageSize ?? Self.defaultImageSize
        self.rightImageSize = rightImageSize ?? Self.defaultImageSize
        // Data
        self.leftImageName = "timetable"
        self.rightImageName = "chevronRight"
        self.title = L10n.News.tableViewComingSectionTitle
    }
}

struct CustomTableViewCellHeaderConfiguration: TableViewCellHeaderConfiguration {
    var leftImageName: String?
    var rightImageName: String?
    var title: String?
    var backgroundColor: CodableColor
    var tintColor: CodableColor
    var textColor: CodableColor
    var size: CGSize
    
    var leftImageSize: CGSize
    var rightImageSize: CGSize
    
    static let defaultSize = CGSize(width: 0, height: 44)
    static let defaultImageSize = CGSize(width: 40, height: 24)
    
    internal init(size: CGSize? = nil,
                  leftImageSize: CGSize? = nil,
                  rightImageSize: CGSize? = nil) {
        // Colors
        self.backgroundColor = Asset.other2.color.codableColor
        self.tintColor = Asset.textColor.color.codableColor
        self.textColor = Asset.textColor.color.codableColor
        // Size
        self.size = size ?? Self.defaultSize
        self.leftImageSize = leftImageSize ?? Self.defaultImageSize
        self.rightImageSize = rightImageSize ?? Self.defaultImageSize
    }
    
    init(leftImageName: String?,
         rightImageName: String?,
         title: String?,
         backgroundColor: CodableColor,
         tintColor: CodableColor,
         textColor: CodableColor,
         size: CGSize? = nil,
         leftImageSize: CGSize? = nil,
         rightImageSize: CGSize? = nil) {
        self.size = size ?? Self.defaultSize
        self.leftImageName = leftImageName
        self.rightImageName = leftImageName
        self.leftImageSize = leftImageSize ?? Self.defaultImageSize
        self.rightImageSize = rightImageSize ?? Self.defaultImageSize
        self.title = L10n.News.tableViewNewsSectionTitle
        self.backgroundColor = Asset.other2.color.codableColor
        self.tintColor = Asset.textColor.color.codableColor
        self.textColor = Asset.textColor.color.codableColor
    }
    
}
