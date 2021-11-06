//
//  HomeViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 9/6/21.
//

import Firebase
import FirebaseDatabaseUI

class HomeViewModel {
    
    // MARK: - Properties
    
    var dataSource: FUITableViewDataSource?
    
    var items: [IndexPath: OldTableRow<SportEvent>] = [:]
    
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
    
    func item(at indexPath: IndexPath) -> SportEvent {
        guard let event = items[indexPath] else {
            fatalError("Cant get item at index \(indexPath.row)")
        }
        return event.data
    }    
    
    func action(at indexPath: IndexPath) -> ActionCollectionCellConfigurator {
        actions[indexPath.item]
    }
    
}
