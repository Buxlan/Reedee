//
//  ActionableTableViewBase.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 14.02.2022.
//

import UIKit

class ActionableTableViewBase: TableViewBase {
    
    
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
//    {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let deleteAction = UITableViewRowAction(style: .normal,
//                                                title: L10n.Finance.Transactions.deactivate) { (_, indexPath) in
//            log.debug("action")
//        }
//        deleteAction.backgroundColor = Colors.Accent.red
//        return [deleteAction]
//    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        
        let row = dataSource.rowFromIndexPath(indexPath)
        guard let contextualAction = row.contextualAction else { return nil }
        
        let switchActivityAction = UIContextualAction(style: .normal,
                                                      title: L10n.Finance.Transactions.switchActivity,
                                                      handler: contextualAction)
        
        switchActivityAction.backgroundColor = .blue
        let configuration = UISwipeActionsConfiguration(actions: [switchActivityAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
}
