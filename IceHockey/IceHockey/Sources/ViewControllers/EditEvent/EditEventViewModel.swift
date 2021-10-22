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
                    EditEventTitleCellConfigurator(data: nil, handler: handler),
                    EditEventTitleTextFieldCellConfigurator(data: data.title, handler: handler),
                    EditEventTextCellConfigurator(data: data.text, handler: handler),
                    EditEventBoldTextCellConfigurator(data: data.boldText, handler: handler),
                    EditEventSaveCellConfigurator(data: nil, handler: handler)
                ]
                handler.reloadData()
            }
        }
    }
    private var handler: EditEventHandler
    private var tableItems: [CellConfigurator] = []
    
    // MARK: Lifecircle
    
    init(handler: EditEventHandler) {
        self.handler = handler
        super.init()
    }
        
    // MARK: - Hepler functions
}

extension EditEventViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let configurator = tableItems[indexPath.row]
        return handler.configureCell(at: indexPath, configurator: configurator)
    }
}

extension EditEventViewModel {
    func save() {
        guard let dataSource = dataSource else {
            return
        }
        self.dataSource?.uid = dataSource.save() ?? ""
        
    }
}
