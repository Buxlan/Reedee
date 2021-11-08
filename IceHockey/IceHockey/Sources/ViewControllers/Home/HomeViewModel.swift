//
//  HomeViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 9/6/21.
//

import Firebase
import FirebaseDatabaseUI

class HomeViewModel: NSObject {
    
    // MARK: - Properties
    
    var dataSource: FUITableViewDataSource?
    
    var items: [IndexPath: TableRow] = [:]
    
    var populateCellRelay: ((UITableView, IndexPath, DataSnapshot) -> UITableViewCell)! {
        didSet {
            guard let populateCellRelay = populateCellRelay else { return }
            dataSource = FUITableViewDataSource(query: databaseQuery, populateCell: populateCellRelay)
        }
    }
    
    private var storageReference: StorageReference = {
        FirebaseManager.shared.storageManager.root.child("events")
    }()
    var databaseQuery: DatabaseQuery {
        FirebaseManager.shared.databaseManager.root.child("events").queryOrdered(byChild: "order")
    }
    
    private lazy var actions: [ActionCollectionCellConfigurator] = {
        [
            ActionCollectionCellConfigurator(data: QuickAction.joinClub),
            ActionCollectionCellConfigurator(data: QuickAction.contacts),
            ActionCollectionCellConfigurator(data: QuickAction.showTrainingSchedule),
            ActionCollectionCellConfigurator(data: QuickAction.showOnMap)
        ]
    }()
    
    var actionsCount: Int {
        actions.count
    }
    
    // MARK: Lifecircle
            
    // MARK: - Hepler functions     
    
    func action(at indexPath: IndexPath) -> ActionCollectionCellConfigurator {
        actions[indexPath.item]
    }
    
    func setupTable(_ tableView: UITableView) {
        tableView.delegate = self
        dataSource?.bind(to: tableView)
    }
    
}

extension HomeViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = self.items[indexPath]
        row?.action()
    }
    
}
