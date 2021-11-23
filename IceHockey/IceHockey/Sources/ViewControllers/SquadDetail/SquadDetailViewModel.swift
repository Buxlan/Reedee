//
//  SquadDetailViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 10/28/21.
//

import Firebase
import FirebaseDatabaseUI

class SquadDetailViewModel: NSObject {
    
    // MARK: - Properties
    
    typealias DataType = SportPlayer
    typealias PredicateType = SportSquad
    typealias CellConfiguratorType = PlayerCellConfigurator
    
    var filter: PredicateType? {
        didSet {
            // get ids
//            guard let filter = filter else {
//                return
//            }
//            let ids = filter.players
//            // get objects
//            objectsDatabaseReference.observe(.value) { snapshot in
//                if snapshot.value == nil {
//                    return
//                }
//                guard let result = snapshot.value as? [String: Any] else {
//                    return
//                }
//                var items: [CellConfigurator] = []
//                ids.forEach { (uid) in
//                    guard let item = result[uid] as? [String: Any] else {
//                        return
//                    }
//                    guard let object = SportPlayer(key: uid, dict: item) else {
//                        fatalError("Invalid Reference")
//                    }
//                    let config = CellConfiguratorType(data: object)
//                    items.append(config)
//                }
//                self.tableItems = items
//                DispatchQueue.main.async {
//                    self.delegate?.reloadData()
//                }
//            }
            
        }
    }
    
    weak var delegate: CellUpdatable?
    private var tableItems: [CellConfigurator] = []
    
    // MARK: Lifecircle
    
    init(delegate: CellUpdatable) {
        super.init()
        self.delegate = delegate
    }
        
    // MARK: - Hepler functions
    
    var objectsDatabaseReference: DatabaseReference {
        FirebaseManager.shared.databaseManager.root.child("players")
    }
    
    // MARK: Lifecircle
            
    // MARK: - Hepler functions
    
    func item(at indexPath: IndexPath) -> DataType {
        guard let config = tableItems[indexPath.row] as? CellConfiguratorType else {
            fatalError("Cant get item at index \(indexPath.row)")
        }
        return config.data
    }

    func deleteItem(at indexPath: IndexPath) {
        let item = self.item(at: indexPath)
        try? item.delete()
    }
    
}

extension SquadDetailViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let configurator = tableItems[indexPath.row]
        return delegate?.configureCell(at: indexPath, configurator: configurator) ?? UITableViewCell()
    }
    
}
