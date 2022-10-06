//
//  TableViewBaseVC.swift
//  IceHockey
//
//  Created by  Buxlan on 11/6/21.
//

import UIKit

class TableViewBase: NSObject {
    var dataSource: TableDataSource

    override init() {
        self.dataSource = TableDataSource()
    }

    init(dataSource: TableDataSource) {
        self.dataSource = dataSource
    }

    func updateDataSource(_ dataSource: TableDataSource) {
        self.dataSource = dataSource
    }

    func setupTable(_ table: UITableView) {
        table.delegate = self
        table.dataSource = self
    }
    
    func updateRow(_ row: TableRow, at indexPath: IndexPath) {
        dataSource.sections[indexPath.section].rows[indexPath.row] = row
    }
    
}

extension TableViewBase: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.sections.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSource.rowFromIndexPath(indexPath).height
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = dataSource.sections[section]
        return section.rows.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource.rowFromIndexPath(indexPath).action(indexPath)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        dataSource.rowFromIndexPath(indexPath).deselectAction(indexPath)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = dataSource.rowFromIndexPath(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: row.rowId, for: indexPath)
        row.config.configure(view: cell)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return dataSource.sections[section].headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return dataSource.sections[section].footerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = dataSource.sections[section]
        guard let headerViewId = section.headerViewId,
              let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerViewId) else {
            return nil
        }

        section.config(header: headerView)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let section = dataSource.sections[section]
        guard let footerViewId = section.footerViewId,
              let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerViewId) else {
            return nil
        }

        section.config(footer: footerView)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        dataSource.rowFromIndexPath(indexPath).willDisplay(cell, indexPath)
    }
}
