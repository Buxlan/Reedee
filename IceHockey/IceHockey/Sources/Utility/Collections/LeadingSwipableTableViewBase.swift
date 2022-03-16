//
//  ActionableTableViewBase.swift
//  IceHockey
//
//  Created by Sergey Bush bushmakin@outlook.com on 14.02.2022.
//

import UIKit

class LeadingSwipableTableViewBase: TableViewBase {
    
    var actionTitle: String
    var actionColor: UIColor
    
    init(actionTitle: String, actionColor: UIColor) {
        self.actionTitle = actionTitle
        self.actionColor = actionColor
        super.init()
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        
        let row = dataSource.rowFromIndexPath(indexPath)
        guard let contextualAction = row.contextualAction else { return nil }
        
        let activityAction = UIContextualAction(style: .normal,
                                                      title: actionTitle,
                                                      handler: contextualAction)
        
        activityAction.backgroundColor = actionColor
        let configuration = UISwipeActionsConfiguration(actions: [activityAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
}
