//
//  ActionableTableViewBase.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 14.02.2022.
//

import UIKit

class LeadingSwipableTableViewBase: TableViewBase {
    
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
