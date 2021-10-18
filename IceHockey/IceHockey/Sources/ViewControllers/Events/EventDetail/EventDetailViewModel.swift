//
//  EventDetailViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 10/18/21.
//

import Firebase
import FirebaseDatabaseUI

class EventDetailViewModel: NSObject {
    
    // MARK: - Properties
    var dataSource: SportEvent? {
        didSet {
            if let data = dataSource {
                tableItems = [EventPhotoTableViewCellConfigurator(data: data.imageNames)]
                delegate?.reloadData()
            }
        }
    }
    weak var delegate: CellUpdatable?
    private var tableItems: [CellConfigurator] = []
    
    // MARK: Lifecircle
        
    // MARK: - Hepler functions
}

extension EventDetailViewModel: UITableViewDataSource {    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let configurator = tableItems[indexPath.row]
        return delegate?.configureCell(at: indexPath, configurator: configurator) ?? UITableViewCell()
    }
}
