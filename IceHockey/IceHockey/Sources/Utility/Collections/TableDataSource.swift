//
//  TableDataSource.swift
//  IceHockey
//
//  Created by  Buxlan on 11/6/21.
//

import UIKit

private struct EmptyContentConfig: ContentConfigurator {
    func configure(view: UIView) {
    }
}

final class TableRow {
    var rowId: String
    var config: ContentConfigurator
    var height: CGFloat = UITableView.automaticDimension
    var action: (IndexPath) -> Void = { _ in }
    var deselectAction: (IndexPath) -> Void = { _ in }
    var willDisplay: (UITableViewCell, IndexPath) -> Void = { (_, _) in }
    
    init(rowId: String,
         config: ContentConfigurator = EmptyContentConfig(),
         height: CGFloat = UITableView.automaticDimension) {
        self.rowId = rowId
        self.config = config
        self.height = height
    }
}

struct TableSection {
    var headerViewId: String?
    var footerViewId: String?
    var headerHeight: CGFloat = 0
    var footerHeight: CGFloat = 0
    var headerConfig: ContentConfigurator
    var footerConfig: ContentConfigurator
    var rows: [TableRow] = []

    mutating func addRow(_ row: TableRow) {
        rows.append(row)
    }

    mutating func addRows(_ rows: [TableRow]) {
        self.rows.append(contentsOf: rows)
    }

    init(headerViewId: String? = nil,
         footerViewId: String? = nil,
         headerConfig: ContentConfigurator = EmptyContentConfig(),
         footerConfig: ContentConfigurator = EmptyContentConfig()) {
        self.headerViewId = headerViewId
        self.footerViewId = footerViewId
        self.headerConfig = headerConfig
        self.footerConfig = footerConfig
    }
    
    func config(header: UITableViewHeaderFooterView) {
        headerConfig.configure(view: header)
    }
    
    func config(footer: UITableViewHeaderFooterView) {
        footerConfig.configure(view: footer)
    }
}

struct TableDataSource {
    var sections: [TableSection] = []
    
    var lastIndexPath: IndexPath {
        let lastSection = sections.count - 1
        let lastRow = sections[lastSection].rows.count - 1
        return IndexPath(row: lastRow, section: lastSection)
    }

    mutating func addSection(_ section: TableSection) {
        sections.append(section)
    }

    mutating func addSections(_ sections: [TableSection]) {
        self.sections.append(contentsOf: sections)
    }

    func rowFromIndexPath(_ indexPath: IndexPath) -> TableRow {
        return sections[indexPath.section].rows[indexPath.row]
    }
}
