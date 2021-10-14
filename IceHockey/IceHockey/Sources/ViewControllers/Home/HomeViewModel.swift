//
//  HomeViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 9/6/21.
//

import Firebase
import FirebaseDatabaseUI

protocol InputData {
    associatedtype DataType
    var inputData: DataType? { get set }
}

struct HomeViewModel {
    var dataSource: FUITableViewDataSource?
    private var databaseReference: DatabaseReference = {
        Database.database(url: "https://icehockey-40e64-default-rtdb.europe-west1.firebasedatabase.app").reference()
    }()
    
    init() {
        dataSource = FUITableViewDataSource(query: getQuery()) { (tableView, indexPath, snap) -> UITableViewCell in
            guard let event = SportEvent(snapshot: snap) else {
                return UITableViewCell()
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: event.type.identifier,
                                                     for: indexPath)
            if let cell = cell as? ConfigurableEventCell {
                cell.configure(with: event)
            }
            return cell
        }
    }
    
    // MARK: - Hepler functions
    
}

extension HomeViewModel {
    private func getQuery() -> DatabaseQuery {
        return databaseReference.child("events")
    }
}
