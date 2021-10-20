//
//  EditEventViewModel.swift
//  IceHockey
//
//  Created by  Buxlan on 10/20/21.
//

import Firebase
import FirebaseDatabaseUI

class EditEventViewModel: NSObject {
    
    // MARK: - Properties
    var dataSource: SportEvent? {
        didSet {
            if let data = dataSource {
                tableItems = [
                    EditEventTitleCellConfigurator(data: nil),
                    EditEventTitleTextFieldCellConfigurator(data: data.title)                                                  
                ]
                delegate?.reloadData()
            }
        }
    }
    private weak var delegate: CellUpdatable?
    private var tableItems: [CellConfigurator] = []
    
    // MARK: Lifecircle
    
    init(delegate: CellUpdatable) {
        super.init()
        self.delegate = delegate
    }
        
    // MARK: - Hepler functions
}

extension EditEventViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let configurator = tableItems[indexPath.row]
        return delegate?.configureCell(at: indexPath, configurator: configurator) ?? UITableViewCell()
    }
}
