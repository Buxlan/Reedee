//
//  DataSource.swift
//  BubbleComics
//
//  Created by Azov Vladimir on 05/03/2019.
//  Copyright © 2019 Bubble. All rights reserved.
//

import UIKit

private struct EmptyContentConfig: ContentConfigurator {
    func configure(view: UIView) {
    }
}

final class CollectionRow {
    var rowId: String
    var config: ContentConfigurator
    var size: CGSize
    var action = {}
    var deselectAction = {}
    var willDisplay = {}
    var endDisplay = {}

    init(rowId: String, config: ContentConfigurator = EmptyContentConfig(),
         size: CGSize = UICollectionViewFlowLayout.automaticSize) {
        self.rowId = rowId
        self.config = config
        self.size = size
    }
}

struct CollectionSection {
    var headerViewId: String?
    var footerViewId: String?
    var headerSize: CGSize = .zero
    var footerSize: CGSize = .zero
    var lineSpacing: CGFloat
    var headerConfig: ContentConfigurator
    var footerConfig: ContentConfigurator
    var rows: [CollectionRow] = []

    mutating func addRow(_ row: CollectionRow) {
        rows.append(row)
    }

    mutating func addRows(_ rows: [CollectionRow]) {
        self.rows.append(contentsOf: rows)
    }

    init(headerViewId: String? = nil,
         footerViewId: String? = nil,
         headerConfig: ContentConfigurator = EmptyContentConfig(),
         footerConfig: ContentConfigurator = EmptyContentConfig(),
         lineSpacing: CGFloat = 16) {
        self.headerViewId = headerViewId
        self.footerViewId = footerViewId
        self.headerConfig = headerConfig
        self.footerConfig = footerConfig
        self.lineSpacing = lineSpacing
    }

    init() {
        lineSpacing = 0
        headerConfig = EmptyContentConfig()
        footerConfig = EmptyContentConfig()
    }
}

struct CollectionDataSource {
    var sections: [CollectionSection] = []

    mutating func addSection(_ section: CollectionSection) {
        sections.append(section)
    }

    mutating func addSections(_ sections: [CollectionSection]) {
        self.sections.append(contentsOf: sections)
    }

    func rowFromIndexPath(_ indexPath: IndexPath) -> CollectionRow {
        return sections[indexPath.section].rows[indexPath.row]
    }
}
