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
    weak var delegate: CellUpdatable? {
        didSet {
            dataSource = FUITableViewDataSource(query: databaseQuery, populateCell: populateCell)
        }
    }
    var dataSource: FUITableViewDataSource?
    
    private lazy var populateCell: ((UITableView, IndexPath, DataSnapshot) -> UITableViewCell) = { (_, indexPath, snap) -> UITableViewCell in
        guard let event = SportEvent(snapshot: snap),
              let delegate = self.delegate else { return UITableViewCell() }
        return delegate.configureCell(at: indexPath, event: event)
    }
    
    private var databaseReference: DatabaseReference = FirebaseManager.shared.databaseManager.root
    private var storageReference: StorageReference = {
        FirebaseManager.shared.storageManager.root.child("events")
    }()
    var databaseQuery: DatabaseQuery {
        databaseReference.child("events")
    }
    
    // MARK: Lifecircle
        
    // MARK: - Hepler functions
    func item(at indexPath: IndexPath) -> SportEvent {
        guard let snapshot = dataSource?.items[indexPath.row],
              let event = SportEvent(snapshot: snapshot) else {
            fatalError("Cant get item at index \(indexPath.row)")
        }
        return event
    }
    
}
